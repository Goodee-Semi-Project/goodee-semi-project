package com.goodee.semi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.NoticeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/filePath")
public class FilePathServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService service = new NoticeService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pkNo = Integer.parseInt(request.getParameter("pkNo"));
		int typeNo = Integer.parseInt(request.getParameter("typeNo"));

		// ✅ Attach 객체 생성 후, DB 조회
		Attach param = new Attach();
		param.setPkNo(pkNo);
		param.setTypeNo(typeNo);

		Attach attach = service.selectAttachOne(param);  // DB에서 가져오기!
		

		// ✅ attach null 체크
		if (attach == null || attach.getSavedName() == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "첨부파일을 찾을 수 없습니다.");
			return;
		}

		String filePath = "C:/goodee/upload/notice/" + attach.getSavedName();
		

		File file = new File(filePath);
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		String mimeType = getServletContext().getMimeType(filePath);
		if (mimeType == null) mimeType = "application/octet-stream";
		response.setContentType(mimeType);

		try (FileInputStream fis = new FileInputStream(file);
			 OutputStream out = response.getOutputStream()) {
			byte[] buffer = new byte[1024];
			int byteRead;
			while ((byteRead = fis.read(buffer)) != -1) {
				out.write(buffer, 0, byteRead);
			}
		}
	}
}
