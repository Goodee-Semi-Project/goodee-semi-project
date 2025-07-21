package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.service.PreTestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PreTestDeleteServlet
 */
@WebServlet("/preTest/delete")
public class PreTestDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreTestService preTestService = new PreTestService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreTestDeleteServlet() {
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
		
		String testNo = request.getParameter("testNo");
		System.out.println(testNo);
		int result = preTestService.delete(testNo);
		
		

		JSONObject obj = new JSONObject();
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "퀴즈 수정 완료");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "퀴즈 삭제 실패");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
