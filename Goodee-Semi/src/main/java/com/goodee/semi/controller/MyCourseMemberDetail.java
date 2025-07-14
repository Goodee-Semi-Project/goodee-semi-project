package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.service.ClassService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myCourse/MemberDetail")
public class MyCourseMemberDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ClassService service = new ClassService();
	
    public MyCourseMemberDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));

		
		
		request.getRequestDispatcher("/WEB-INF/views/myCourse/memberDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
