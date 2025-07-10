package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.service.AccountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class MyInfoEditPw
 */
@WebServlet("/myInfo/editPw")
public class MyInfoEditPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService service = new AccountService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoEditPwServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String currentPw = request.getParameter("currentPw");
		String newPw = request.getParameter("newPw");
//		String newPwCheck = request.getParameter("newPwCheck");
		
		HttpSession session = request.getSession();
		
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		int result = -1;
		if (account != null && account.getAccountId() != null) {
			account.setAccountPw(currentPw);
			result = service.updateAccountPw(account, newPw);
		}
		
		JSONObject obj = new JSONObject();

		obj.put("res_code", "500");
		obj.put("res_msg", "비밀번호가 다릅니다.");
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "비밀번호가 변경 되었습니다.");
		}

		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
