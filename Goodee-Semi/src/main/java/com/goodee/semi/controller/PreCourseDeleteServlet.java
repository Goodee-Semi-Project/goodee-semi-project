package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.service.PreCourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class PreCourseDeleteServlet
 */
@WebServlet("/preCourse/delete")
public class PreCourseDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreCourseService preCourseService = new PreCourseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseDeleteServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") != null) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		int preNo = Integer.parseInt(request.getParameter("no"));
		
		PreCourse preCourse = preCourseService.selectPreCourse(preNo);
		if (preCourse.getAccountNo() != account.getAccountNo()) {
			
			request.getRequestDispatcher("/preCourse/list").forward(request, response);
			return;
		}
		// TODO: 진행중
		// TODO: 진행중
		// TODO: 진행중
		
		request.setAttribute("preCourse", preCourse);
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseEdit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
