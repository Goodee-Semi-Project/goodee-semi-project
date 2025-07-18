package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Event;
import com.goodee.semi.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventService service = new EventService();

    public ScheduleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 로그인한 사용자만 접근을 허용하는 로직
		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		} else if(session.getAttribute("loginAccount") == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		// 2. session에서 accountNo 가져오기
		AccountDetail accountDetail = (AccountDetail) session.getAttribute("loginAccount");
		int authorNo = accountDetail.getAuthor();
		int accountNo = accountDetail.getAccountNo();

		// 훈련사와 회원은 서로 다른 페이지로 이동
		if(authorNo == 1) {
			// 3. 모달에 표시할 정보 service로부터 받아와 바인딩
			List<Event> courseList = service.selectCourseList(accountNo);
			request.setAttribute("courseList", courseList);
			
			request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_trainer.jsp").forward(request, response);
		}
		else request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_member.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
