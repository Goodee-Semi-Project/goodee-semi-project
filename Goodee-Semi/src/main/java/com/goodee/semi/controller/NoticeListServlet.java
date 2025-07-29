package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;
import com.goodee.semi.service.NoticeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


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
		param.setNumPerPage(5); // 공지사항 페이지에서는 5개씩 보이도록
		param.setNowPage(1);
		// paging이 음수처리 -> 시작을 1로 설정
		if(nowPage != null) {
			param.setNowPage(Integer.parseInt(nowPage));
		}
		param.setKeyword(keyword);
		int totalData = service.selectListCount(param);
		param.setTotalData(totalData);
		
		List<Notice> list = service.selectList(param);
		for (Notice notice : list) {
			notice.setNoticeContent(notice.getNoticeContent().substring(0, notice.getNoticeContent().length() > 50 ? 50 : notice.getNoticeContent().length()) + "...");
			
			Attach attParam = new Attach();
			attParam.setPkNo(notice.getNoticeNo());
			attParam.setTypeNo(Attach.NOTICE); 
			
			Attach attach = service.selectAttachOne(attParam);
			if (attach != null) notice.setNoticeAttach(attach);
		}
		
		request.setAttribute("noticeList", list);
		request.setAttribute("paging", param);
		request.getRequestDispatcher("/WEB-INF/views/notice/list.jsp").forward(request, response);
	}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
