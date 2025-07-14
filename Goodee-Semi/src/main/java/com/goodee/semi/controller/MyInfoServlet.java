package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.AttachService;

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
	AccountService accountService = new AccountService();
	AttachService attachService = new AttachService();
       
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
		HttpSession session = request.getSession(false);
		// TODO: 로그인 정보 받아오기
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		String accountId = null;
		if (account != null && account.getAccountId() != null) {
			accountId = account.getAccountId();
		}
		
		AccountDetail accountDetail = accountService.selectAccountDetail(accountId);
		Attach attach = accountService.selectAttachByAccountNo(account.getAccountNo());
		
		request.setAttribute("accountDetail", accountDetail);
		if (attach != null) {
			request.setAttribute("attach", attach);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/myInfo/myInfoPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
