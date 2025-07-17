package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.ClassService;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PetService;

@WebServlet("/myCourse/list")
public class MyCourseListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
	private PetService petService = new PetService();
	private ClassService classService = new ClassService();
       
  public MyCourseListServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		List<Course> courseList = courseService.selectMyCourse(account);
		
		if (account.getAuthor() == 1) {
			for (Course course : courseList) {
				course.setPetInCourseCount(petService.selectAllPetByCourseNo(String.valueOf(course.getCourseNo())).size());
			}
			
			request.setAttribute("courseList", courseList);
		}
		
		if (account.getAuthor() == 2) {
			List<Course> myCourseList = new ArrayList<Course>();
			
			for (Course course : courseList) {
				List<Pet> myPetInCourse = petService.selectMyPetInCourse(course, account);
				
				for (Pet pet : myPetInCourse) {
					Course courseByPet = courseService.selectCourseOne(String.valueOf(course.getCourseNo()));
					courseByPet.setMyPetInCourse(pet);
					courseByPet.setClassData(classService.selectClassByCourseNoAndPetNo(course.getCourseNo(), pet.getPetNo()));
					
					myCourseList.add(courseByPet);
				}
			}
			
			request.setAttribute("courseList", myCourseList);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/myCourse/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
