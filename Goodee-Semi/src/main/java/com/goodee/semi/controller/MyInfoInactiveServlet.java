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
 * Servlet implementation class MyInfoInactiveServlet
 */
@WebServlet("/myInfo/inactive")
public class MyInfoInactiveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService service = new AccountService();
       
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
		
		String checkPw = null;
		if (request.getParameter("checkPw") != null) {
			checkPw = request.getParameter("checkPw");
		}
		
		JSONObject obj = new JSONObject();
		
		obj.put("res_code", "500");
		obj.put("res_msg", "비밀번호가 다릅니다.");
		
		if (checkPw != null) {
			HttpSession session = request.getSession();
			Account account = null;
			
			if (session != null && session.getAttribute("loginAccount") instanceof Account) {
				account = (Account) session.getAttribute("loginAccount");
			}
			
			int result = -1;
			if (account != null && account.getAccountId() != null) {
				account.setAccountPw(checkPw);
				result = service.deactivateAccount(account);
			}
			
			if (result > 0) {
				// TODO: 탈퇴 처리
				session.removeAttribute("loginAccount");
				
				obj.put("res_code", "200");
				obj.put("res_msg", "탈퇴 되었습니다.");
			}
		}

		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
