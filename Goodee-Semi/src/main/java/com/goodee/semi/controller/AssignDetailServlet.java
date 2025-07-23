package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.goodee.semi.dto.Assign;
import com.goodee.semi.service.AssignService;

@WebServlet("/assign/detail")
public class AssignDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
  public AssignDetailServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String assignNo = request.getParameter("assignNo");
		
		Assign assign = service.selectAssign(assignNo);
		assign.setAssignContent(assign.getAssignContent().replaceAll("\n", "<br>"));
		
		request.setAttribute("assign", assign);
		request.getRequestDispatcher("/WEB-INF/views/assign/detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
