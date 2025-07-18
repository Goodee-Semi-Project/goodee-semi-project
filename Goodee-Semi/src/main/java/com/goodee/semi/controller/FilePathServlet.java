package com.goodee.semi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AttachService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FilePathServlet
 */
@WebServlet("/filePath")
public class FilePathServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AttachService service = new AttachService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FilePathServlet() {
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
		
		String mimeType = getServletContext().getMimeType(filePath);
		if (mimeType == null) mimeType = "application/octet-stream";
		response.setContentType(mimeType);
		
		try (FileInputStream fis = new FileInputStream(file);
				OutputStream os = response.getOutputStream()) {
			byte[] buffer = new byte[1024 * 1024];
			int byteRead;
			while ((byteRead = fis.read(buffer)) != -1) {
				os.write(buffer, 0, byteRead);
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
