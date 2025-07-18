package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/attend/detail")
public class AttendDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AttendDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int petNo = Integer.parseInt(request.getParameter("no"));
		System.out.println(petNo);
		
		request.getRequestDispatcher("/WEB-INF/views/attend/attendDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
