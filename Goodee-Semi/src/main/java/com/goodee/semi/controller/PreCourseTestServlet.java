package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.PreTest;
import com.goodee.semi.service.PreTestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PreCourseTestServlet
 */
@WebServlet("/preCourse/test")
public class PreCourseTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreTestService preTestService = new PreTestService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseTestServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String preNo = null;
		if (request.getParameter("no") != null) {
			preNo = request.getParameter("no");
		}
		
		List<PreTest> list = preTestService.selectList(preNo);
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseTest.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
