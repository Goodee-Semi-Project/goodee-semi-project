package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Pet;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		Pet param = new Pet();
		param.setAccountNo(accountDetail.getAccountNo());
		
		// 3. 표시할 회원 정보 바인딩
		int authorNo = accountDetail.getAuthor();
		String authurName = (authorNo == 1) ? "훈련사" : "회원";
		String regDate = accountDetail.getReg_date().split(" ")[0].replace("-", ".");
		request.setAttribute("authurName", authurName);
		request.setAttribute("regDate", regDate);
		
		// 훈련사와 회원은 서로 다른 페이지로 이동
		if(authorNo == 1) request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_trainer.jsp").forward(request, response);
		else request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_member.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
