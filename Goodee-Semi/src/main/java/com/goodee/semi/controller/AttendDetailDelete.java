package com.goodee.semi.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attend/detailDelete")
public class AttendDetailDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ScheduleService scheduleService = new ScheduleService();   
	
    public AttendDetailDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int schedNo = Integer.parseInt(request.getParameter("schedno"));
		
		
	}

}
