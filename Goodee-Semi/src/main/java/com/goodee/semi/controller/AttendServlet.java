package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.CourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/attend")
public class AttendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CourseService courseService = new CourseService();
	
	public AttendServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		Account account = (Account)session.getAttribute("loginAccount");
		int accountNo = 0;
		int author = 0;
		
		if(account != null) {
			 accountNo = account.getAccountNo();
			 author = account.getAuthor();
		}
		
		List<Course> courseList = null;
		
		switch (author) {
		case 1: courseList = courseService.selectAllCourseByAccountNo(accountNo); break;
		case 2: courseList = null;
			break;
		}
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/WEB-INF/views/attend/attend.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
