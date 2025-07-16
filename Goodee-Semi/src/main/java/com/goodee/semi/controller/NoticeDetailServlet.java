package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;
import com.goodee.semi.service.NoticeService;


@WebServlet("/noticeDetail")
public class NoticeDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private NoticeService service = new NoticeService();   
   
    public NoticeDetailServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeNo = Integer.parseInt(request.getParameter("no"));
		
		Notice notice = service.selectNoticeDetail(noticeNo);
		Attach param = new Attach();
		param.setPkNo(noticeNo);
		param.setTypeNo(Attach.NOTICE); 
		Attach attach = service.selectAttachOne(param);
		
		
		request.setAttribute("notice", notice);
		request.setAttribute("attach", attach);
		
		request.getRequestDispatcher("/WEB-INF/views/notice/noticeDetail.jsp").forward(request, response);
	}
		
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
