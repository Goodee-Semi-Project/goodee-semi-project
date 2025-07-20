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

		if (account != null) {
		    // 로그인 성공
		    HttpSession session = request.getSession();
		    session.setAttribute("loginAccount", account);
		    session.setMaxInactiveInterval(60 * 30);

		    obj.put("res_code", "200");
		    obj.put("res_msg", account.getName() + "님 환영합니다!");
		} else {
		    // 존재하는 아이디인지 다시 조회
		    AccountDetail foundAccount = service.selectAccountById(accountId);

		    if (foundAccount == null) {
		        obj.put("res_code", "404");
		        obj.put("res_msg", "존재하지 않는 아이디입니다.");
		    } else if (foundAccount.getAvailable() == 'N') {
		        obj.put("res_code", "403");
		        obj.put("res_msg", "탈퇴한 회원입니다.");
		    } else {
		        obj.put("res_code", "401");
		        obj.put("res_msg", "비밀번호가 일치하지 않습니다.");
		    }
		}
	
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(obj);
	}
}
