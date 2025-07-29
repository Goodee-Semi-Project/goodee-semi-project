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
 * Servlet implementation class MyInfoRemoveImgServlet
 */
@WebServlet("/myInfo/removeImg")
public class MyInfoRemoveImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService service = new AccountService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoRemoveImgServlet() {
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
		
		// 프로필 이미지 삭제
		int accountNo = -1;
		if (request.getParameter("accountNo") != null) {
			accountNo = Integer.parseInt(request.getParameter("accountNo"));
		}
		
		int result = -1;
		if (accountNo != -1) {
			result = service.deleteAttach(accountNo);
		}
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			// 세션에 등록된 이미지 지우기
			HttpSession session = request.getSession(false);

			Account account = null;
			if (session != null && session.getAttribute("loginAccount") instanceof Account) {
				account = (Account) session.getAttribute("loginAccount");
			}
			account.setProfileAttach(null);
			
			obj.put("res_code", "200");
			obj.put("res_msg", "삭제되었습니다.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "삭제 요청에 실패했습니다.");
		}
		
		response.setContentType("applictaion/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
