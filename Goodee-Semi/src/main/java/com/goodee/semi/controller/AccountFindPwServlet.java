package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.goodee.semi.common.mail.MailSender;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.service.AccountService;

@WebServlet("/account/findPw")
public class AccountFindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService accountService = new AccountService();
       
  public AccountFindPwServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/account/findPw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		
		String accountId = request.getParameter("accountId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		AccountDetail account = new AccountDetail();
		account.setAccountId(accountId);
		account.setName(name);
		account.setEmail(email);
		
		Account resultAccount = accountService.selectAccountByIdNameEmail(account);
		
		if (resultAccount.getAccountId() != null) {
			String authCode = String.valueOf(generateCode());
			session.setAttribute("authCode", authCode);
			MailSender.sendEmail(email, authCode);
			System.out.println("이거 되면 집에 가도 된다");
		}
	}
	
	private int generateCode() {
		int code = (int) ((Math.random() * 900000) + 100000);
		
		return code;
	}

}
