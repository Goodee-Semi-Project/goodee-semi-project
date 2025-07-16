package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.NoticeService;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/notice/write")
public class NoticeWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AttachService fileService = new AttachService();
	private NoticeService noticeService = new NoticeService();
    
    public NoticeWriteServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/notice/register.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		Account loginAccount = (Account) request.getSession().getAttribute("loginAccount");
	    int accountNo = loginAccount.getAccountNo();
		
	    Part inputPart = null;
	    
		Notice notice = new Notice();
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);
		notice.setAccountNo(accountNo);
		
		try {
			inputPart = request.getPart("upfile");
			
		} catch (IOException | ServletException e) { e.printStackTrace(); }
		
		File uploadDir = AttachService.getUploadDirectory(Attach.NOTICE);
		
		
		Attach inputAttach = AttachService.handleUploadFile(inputPart, uploadDir);
		

		
		int result = noticeService.insertNotice(notice, inputAttach);
		
		
		JSONObject jsonObj = new JSONObject();
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "공지사항이 등록되었습니다.");
		} else {
			jsonObj.put("resultCode", "500");
			jsonObj.put("resultMsg", "공지사항 등록 중 오류가 발생했습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj.toJSONString());
	}

}
