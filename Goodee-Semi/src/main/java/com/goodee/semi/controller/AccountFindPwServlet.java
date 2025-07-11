package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;

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

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String inputAuthCode = request.getParameter("authCode");
		
		String accountId = request.getParameter("accountId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		AccountDetail account = new AccountDetail();
		account.setAccountId(accountId);
		account.setName(name);
		account.setEmail(email);
		
		if (inputAuthCode == null) {
			Account resultAccount = accountService.selectAccountByIdNameEmail(account);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("resultCode", "500");
			jsonObj.put("resultMsg", "입력한 데이터와 일치하는 회원이 존재하지 않습니다.");
			
			if (resultAccount.getAccountId() != null) {
				String authCode = String.valueOf(generateCode());
				session.setAttribute("authCode", authCode);
				MailSender.sendEmail(email, authCode);
				
				jsonObj.put("resultCode", "200");
				jsonObj.put("resultMsg", "인증번호를 전송했습니다!");
			}
			
			response.setContentType("application/json; charset=UTF-8");
			response.getWriter().print(jsonObj);
		} else {
			JSONObject jsonObj = new JSONObject();
			String correctCode = (String) session.getAttribute("authCode");
			
			jsonObj.put("resultCode", "500");
			jsonObj.put("resultMsg", "인증번호 확인 도중 오류가 발생했습니다.");
			
			if (correctCode == null) {
				jsonObj.put("resultCode", "400");
				jsonObj.put("resultMsg", "먼저 회원 인증을 진행해주세요.");
			} else if (!inputAuthCode.equals(correctCode)) {
				jsonObj.put("resultCode", "404");
				jsonObj.put("resultMsg", "인증번호가 일치하지 않습니다.");
			} else if (inputAuthCode.equals(correctCode)) {
				jsonObj.put("resultCode", "200");
				jsonObj.put("resultMsg", "회원 인증에 성공했습니다!");
				session.removeAttribute("authCode");
				session.setAttribute("findAccount", account);
			}
			
			response.setContentType("application/json; charset=UTF-8");
			response.getWriter().print(jsonObj);
		}
	}
	
	private int generateCode() {
		int code = (int) ((Math.random() * 900000) + 100000);
		
		return code;
	}

}
