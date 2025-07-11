package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Notice;
import com.goodee.semi.service.NoticeService;


@WebServlet("/notice/list")
public class NoticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private NoticeService service = new NoticeService();   
    
    public NoticeListServlet() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
			
		String nowPage = request.getParameter("nowPage");
		String keyword = request.getParameter("keyword");
		
		Notice param = new Notice();
		param.setNowPage(1);
		// paging이 음수처리 될까봐 시작을 1로 설정
		if(nowPage != null) {
			param.setNowPage(Integer.parseInt(nowPage));
		}
		param.setKeyword(keyword);
		int totalData = service.selectListCount(param);
		param.setTotalData(totalData);
		
		List<Notice> list = service.selectList(param);
		request.setAttribute("noticeList", list);
		request.setAttribute("paging", param);
		request.getRequestDispatcher("/WEB-INF/views/notice/list.jsp").forward(request, response);
		
	}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
