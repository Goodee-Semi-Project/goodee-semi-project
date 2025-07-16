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
 * Servlet implementation class PreCourseServlet
 */
@WebServlet("/preCourse/list")
public class PreCourseListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
	PreCourseService preCourseService = new PreCourseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseListServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		// 회원이 사전학습을 조회
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		if (account.getAuthor() == 1) {
			response.sendRedirect("/preCourse/manage");
			return;
		}
		
		// SJ: 수강에 대한 기능이 필요함
		List<Course> courseList = courseService.selectListByPetAccount(account.getAccountNo());
		
		Map<Integer, List<PreCourse>> preCourseMap = preCourseService.selectMap(courseList);
		request.setAttribute("courseList", courseList);
		request.setAttribute("preCourseMap", preCourseMap);
		
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
