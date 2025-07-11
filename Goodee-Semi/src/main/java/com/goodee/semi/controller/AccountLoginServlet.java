package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.service.AccountService;


@WebServlet("/account/login")
public class AccountLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService service = new AccountService();
    

  public AccountLoginServlet() {
    super();
  }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/account/login.jsp").forward(request, response);;
	}

	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String accountId = request.getParameter("accountId");
		String accountPw = request.getParameter("accountPw");
		
		AccountDetail account = service.getLoginInfo(accountId, accountPw);
		
		JSONObject obj = new JSONObject();
		obj.put("res_code", "401");
		obj.put("res_msg", "로그인 실패");
		
		if(account != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("loginAccount", account);
			session.setMaxInactiveInterval(60 * 30);
			
			obj.put("res_code", "200");
			obj.put("res_msg", "로그인 성공");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
