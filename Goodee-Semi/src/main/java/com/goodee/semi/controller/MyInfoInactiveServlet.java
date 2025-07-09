package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class MyInfoInactiveServlet
 */
@WebServlet("/myInfo/inactive")
public class MyInfoInactiveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoInactiveServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: 나의 반려견 리스트
		
		request.getRequestDispatcher("/WEB-INF/views/myInfo/myInfoInactive.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: 비밀번호 확인을 세션으로?
		request.setCharacterEncoding("UTF-8");

		String checkPw = request.getParameter("checkPw");
		
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("loginAccount");
		String accountId = account.getAccountId();
		
	}

}
