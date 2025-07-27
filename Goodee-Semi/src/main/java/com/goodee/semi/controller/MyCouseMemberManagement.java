package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Course;
import com.goodee.semi.service.CourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myCourse/memberManagement")
public class MyCouseMemberManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CourseService service = new CourseService();
       
    public MyCouseMemberManagement() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		Account account = (Account)session.getAttribute("loginAccount");
		if(account == null || account.getAuthor() != Account.TRAINER_AUTHOR) {
			request.getRequestDispatcher("/WEB-INF/views/info/invalidAccess.jsp").forward(request, response);
		}
		
		int accountNo = account.getAccountNo();
		
		List<Course> courseList = service.selectAllCourseByAccountNo(accountNo);
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/WEB-INF/views/myCourse/memberManagement.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
