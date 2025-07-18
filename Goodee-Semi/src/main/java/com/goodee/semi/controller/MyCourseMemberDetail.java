package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myCourse/memberDetail")
public class MyCourseMemberDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
  private CourseService courseService = new CourseService();
  private PetService petService = new PetService();
	
    public MyCourseMemberDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseNo = request.getParameter("courseNo");

		Course course = courseService.selectCourseOne(courseNo);
		List<Pet> petList = petService.selectAllPetByCourseNo(courseNo);
		
		request.setAttribute("course", course);
		request.setAttribute("petList", petList);
		request.getRequestDispatcher("/WEB-INF/views/myCourse/memberDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
