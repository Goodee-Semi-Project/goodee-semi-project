package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.goodee.semi.dto.Course;
import com.goodee.semi.service.CourseService;

@WebServlet("/course/detail")
public class CourseDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public CourseDetailServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseNo = request.getParameter("no");
		
		Course course = courseService.selectCourseOne(courseNo);
		course.setObject(course.getObject().replaceAll("\n", "<br>"));
		
		request.setAttribute("course", course);
		request.getRequestDispatcher("/WEB-INF/views/course/detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
