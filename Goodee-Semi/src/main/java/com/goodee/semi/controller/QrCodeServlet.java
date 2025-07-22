package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/qr/qrCode")
public class QrCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QrCodeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		
		request.setAttribute("schedNo", schedNo);
		request.getRequestDispatcher("/WEB-INF/views/attend/attendQr.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
