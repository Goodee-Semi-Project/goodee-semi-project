package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.service.AccountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class myInfoServlet
 */
@WebServlet("/myInfo")
public class MyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService service = new AccountService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		// TODO: 로그인 정보 받아오기
		Account accountDetail = null;
		if (session != null && session.getAttribute("loginAccount") instanceof AccountDetail) {
			accountDetail = (AccountDetail) session.getAttribute("loginAccount");
		}
		
//		int accountNo = 1;
//		AccountDetail accountDetail = service.selectAccountDetail(accountNo);
		
		// CARE: 세션에 회원 정보 입력
//		session.setAttribute("accountDetail", accountDetail);
//		session.setMaxInactiveInterval(60 * 30);
		
		request.getRequestDispatcher("/WEB-INF/views/myInfo/myInfoPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
