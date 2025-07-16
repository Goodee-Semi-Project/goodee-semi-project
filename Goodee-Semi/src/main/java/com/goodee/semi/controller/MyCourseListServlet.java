package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Course;
import com.goodee.semi.service.CourseService;

@WebServlet("/myCourse/list")
public class MyCourseListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public MyCourseListServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		List<Course> courseList = courseService.selectMyCourse(account);
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/WEB-INF/views/myCourse/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
