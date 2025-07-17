package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Course;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/attend")
public class AttendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CourseService courseService = new CourseService();
	PetService petService = new PetService();
	
	public AttendServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		AccountDetail account = (AccountDetail)session.getAttribute("loginAccount");

		int accountNo = account.getAccountNo();
		int author = account.getAuthor();
		
		List<Course> courseList = null;
		
		if (author == 1) {
			courseList = courseService.selectAllCourseByAccountNo(accountNo);
		}
		if (author == 2) {
			courseList = courseService.selectMyCourse(account);
			for (Course cs : courseList) {
				cs.setPetList(petService.selectMyPetInCourse(cs, account));
			}
		}
	
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/WEB-INF/views/attend/attend.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
