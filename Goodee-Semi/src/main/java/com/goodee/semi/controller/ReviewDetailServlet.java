package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Review;
import com.goodee.semi.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReviewDetailServlet
 */
@WebServlet("/review/detail")
public class ReviewDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewService reviewService = new ReviewService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewNo = 0;
		String reviewNoStr = request.getParameter("no");
		if (reviewNoStr != null && !"".equals(reviewNoStr)) {
			reviewNo = Integer.parseInt(reviewNoStr);
		}
		
		// TODO: 첨부파일 통일화 후 수정
		Review review = reviewService.selectReivewOne(reviewNo);
		
		request.setAttribute("review", review);
		request.getRequestDispatcher("/WEB-INF/views/review/reviewDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
