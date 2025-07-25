package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Like;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.Review;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PetService;

@WebServlet("/course/detail")
public class CourseDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService accountService = new AccountService();
	private CourseService courseService = new CourseService();
	private PetService petService = new PetService();
       
  public CourseDetailServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseNo = request.getParameter("no");
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		Course course = courseService.selectCourseOne(courseNo);
		course.setObject(course.getObject().replaceAll("\n", "<br>"));
		course.setProfileAttach(accountService.selectAttachByAccountNo(course.getAccountNo()));
		
		if (account != null && account.getAuthor() == 2) {
			Pet pet = new Pet();
			pet.setAccountNo(account.getAccountNo());
			List<Pet> myPetList = petService.selectPetList(pet);
			
			request.setAttribute("myPetList", myPetList);
			
			Like like = new Like();
			like.setCourseNo(course.getCourseNo());
			like.setAccountNo(account.getAccountNo());
			
			Like resultLike = courseService.selectLike(like);
			
			if (resultLike != null) {
				request.setAttribute("isLike", "Y");
			} 
			
		}
		
		List<Review> reviewList = courseService.selectFiveReviewByCourseNo(course.getCourseNo());
		if (reviewList != null) {
			request.setAttribute("reviewList", reviewList);
		}
		
		request.setAttribute("course", course);
		request.getRequestDispatcher("/WEB-INF/views/course/detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
