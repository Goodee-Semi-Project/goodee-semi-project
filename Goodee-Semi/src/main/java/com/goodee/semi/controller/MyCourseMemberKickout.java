package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.service.ClassService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myCourse/memberKickout")
public class MyCourseMemberKickout extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ClassService service = new ClassService();
	
    public MyCourseMemberKickout() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int classNo = Integer.parseInt(request.getParameter("no"));
		
		int result = service.deleteClass(classNo);
		
		response.setContentType("text/plain; charset=utf-8");
		response.getWriter().println(result);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
