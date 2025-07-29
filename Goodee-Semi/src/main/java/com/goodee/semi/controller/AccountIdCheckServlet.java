package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.service.AccountService;

@WebServlet("/account/idCheck")
public class AccountIdCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService service = new AccountService();
       
  public AccountIdCheckServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String accountId = request.getParameter("accountId");
		AccountDetail account = service.selectAccountById(accountId);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "이미 사용중인 아이디입니다.");
		
		if (account == null) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "사용 가능한 아이디입니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
