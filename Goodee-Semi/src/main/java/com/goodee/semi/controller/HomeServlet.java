package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Course;
import com.goodee.semi.service.CourseService;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public HomeServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Course> courseList = courseService.selectCourse(new Course());
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String keyTitle = request.getParameter("searchByTitle").trim();
		String keyName = request.getParameter("searchByTrainer").trim();
		String keyTag = request.getParameter("searchByTag").trim();
		
		List<Course> courseList = null;
		
		if ("".equals(keyTag)) {
			Course course = new Course();
			course.setTitle(keyTitle);
			course.setName(keyName);
			
			courseList = courseService.selectCourse(course);
		} else {
			courseList = courseService.selectCourseByTag(keyTag);
		}
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
