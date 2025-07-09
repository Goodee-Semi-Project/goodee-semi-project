package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.service.AccountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MyInfoEditPw
 */
@WebServlet("/myInfo/editPw")
public class MyInfoEditPw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService service = new AccountService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoEditPw() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		
		
	}

}
