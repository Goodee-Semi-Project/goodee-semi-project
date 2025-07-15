package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.service.PreCourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PreCourseManageDetailServlet
 */
@WebServlet("/preCourse/detail")
public class PreCourseDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreCourseService preCourseService = new PreCourseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int preNo = -1;
		if (request.getParameter("preNo") != null) {
			preNo = Integer.parseInt(request.getParameter("preNo"));
		}
		
		PreCourse preCourse = null;
		if (preNo != -1) {
			preCourse = preCourseService.selectPreCourse(preNo);
		}
		
		if (preCourse != null) {
			Attach attach = preCourseService.selectAttach(preNo);
			
			if (attach != null) {
				request.setAttribute("preCourse", preCourse);
				request.setAttribute("attach", attach);
			}
			
		}

		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
