package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ScheduleDeleteServlet")
public class ScheduleDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
//		
//		int result = service.delete(schedNo);
//		
//		JSONObject json = 
//		if (result != 0) {
//			
//		}
	}

}
