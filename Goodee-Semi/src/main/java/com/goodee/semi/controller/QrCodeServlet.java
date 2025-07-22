package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Schedule;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qr/qrCode")
public class QrCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QrCodeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		
		Schedule sched = new Schedule();
		sched.setSchedNo(schedNo);
		sched.setPetNo(petNo);
		sched.setCourseNo(courseNo);
		
		request.setAttribute("sched", sched);
		request.getRequestDispatcher("/WEB-INF/views/attend/attendQr.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
