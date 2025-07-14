package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PreCourseRegistServlet
 */
@WebServlet("/preCourse/regist")
public class PreCourseRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseRegistServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseRegist.jsp").forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		int courseNo = -1;
		if (request.getParameter("courseNo") != null) {
			courseNo = Integer.parseInt(request.getParameter("courseNo"));
		}

		JSONObject obj = new JSONObject();
		obj.put("res_code", "200");
		obj.put("res_msg", "요청 수신 완료");
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
