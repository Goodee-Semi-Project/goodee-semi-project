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
import com.goodee.semi.dto.Like;
import com.goodee.semi.service.CourseService;

@WebServlet("/myCourse/likeList")
public class MyCourseLikeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public MyCourseLikeListServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		List<Like> likeList = courseService.selectMyLikeByAccountNo(account.getAccountNo());
		
		request.setAttribute("likeList", likeList);
		request.getRequestDispatcher("/WEB-INF/views/myCourse/like.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
