package com.goodee.semi.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AttachService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileStreamServlet
 */
@WebServlet("/fileStream")
public class FileStreamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AttachService service = new AttachService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileStreamServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int attachNo = -1;
		if (request.getParameter("no") != null) {
			attachNo = Integer.parseInt(request.getParameter("no"));
		}
		
		Attach attach = null;
		String filePath = null;
		if (attachNo != -1) {
			attach = service.selectAttachNo(attachNo);
			
			filePath = "C://goodee/upload/" + switch (attach.getTypeNo()) {
			case Attach.ACCOUNT -> "account/";
			case Attach.PET -> "pet/";
			case Attach.COURSE -> "course/";
			case Attach.PRE_COURSE -> "preCourse/";
			case Attach.ASSIGN -> "assign/";
			case Attach.SUBMIT -> "submit/";
			case Attach.REVIEW -> "review/";
			case Attach.NOTICE -> "notice/";
			default -> "";
			} + attach.getSavedName();
		}
		
		if (filePath == null || filePath.trim().equals("") ) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		File file = new File(filePath);
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		long rangeStart = 0, rangeEnd = 0;
		boolean isPart = false;
		
		try (RandomAccessFile randomFile = new RandomAccessFile(file, "r");
				BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {
			long movieSize = randomFile.length();
			String range = request.getHeader("range");
			
			if (range != null) {
				if(range.endsWith("-")) {
					range = range + (movieSize -1);
				}
				int idxm = range.trim().indexOf("-");
				rangeStart = Long.parseLong(range.substring(6, idxm));
				rangeEnd = Long.parseLong(range.substring(idxm + 1));
				
				if(rangeStart > 0) isPart = true;
			} else {
				rangeStart = 0;
				rangeEnd = movieSize - 1;
			}
			
			long partSize = rangeEnd - rangeStart + 1;
			response.reset();
			response.setStatus(isPart ? 206 : 200);
			
			String mimeType = getServletContext().getMimeType(filePath);
			if (mimeType == null) mimeType = "application/octet-stream";
			response.setContentType(mimeType);
			
			response.setHeader("Content-Range", "bytes " + rangeStart + "-" + rangeEnd + "/" + movieSize);
			response.setHeader("Accept-Ranges", "bytes");
			response.setHeader("Content-Length", String.valueOf(partSize));
			randomFile.seek(rangeStart);

			int bufferSize = 8 * 1024;
			byte[] buffer = new byte[bufferSize];
			int byteRead = partSize > bufferSize ? bufferSize : (int) partSize;
			while (partSize > 0) {
				int len = randomFile.read(buffer, 0, byteRead);
				bos.write(buffer, 0, len);
				partSize -= byteRead;
			}
		} catch (Exception e) {
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
