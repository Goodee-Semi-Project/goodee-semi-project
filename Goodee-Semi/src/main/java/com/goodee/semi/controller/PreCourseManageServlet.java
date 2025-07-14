package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PreCourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class PreCourseManageServlet
 */
@WebServlet("/preCourse/manage")
public class PreCourseManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CourseService courseService = new CourseService();
	PreCourseService preCourseService = new PreCourseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseManageServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		// TODO: 훈련사 권한이 아니면 redirection
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
		}
		List<Course> courseList = courseService.selectList(account.getAccountNo());
		// TODO: courseList 넘기기
		session.setAttribute("courseList", courseList);
		session.setMaxInactiveInterval(60 * 30);
		
		Map<Integer, List<PreCourse>> preCourseMap = preCourseService.selectMap(courseList);
		request.setAttribute("courseList", courseList);
		request.setAttribute("preCourseMap", preCourseMap);
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseManage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseRegist.jsp").forward(request, response);
	}

}
