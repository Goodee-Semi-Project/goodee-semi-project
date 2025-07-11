package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Review;
import com.goodee.semi.service.ReviewService;

/**
 * Servlet implementation class ReviewListServlet
 */
@WebServlet("/review/list")
public class ReviewListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService service = new ReviewService();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewListServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Review param = new Review();
		// 현재 페이지
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if (nowPageStr != null) nowPage = Integer.parseInt(nowPageStr);
		param.setNowPage(nowPage);
		
		// 검색어
		String keyword = request.getParameter("keyword");
		param.setKeyword(keyword);
		
		// 게시글 개수
		int totalData = service.selectReviewCount(param);
		param.setTotalData(totalData);
		
		// 리뷰 목록
		List<Review> reviewList = service.selectReviewList(param);
		
		
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("paging", param);
		
		request.getRequestDispatcher("/WEB-INF/views/review/reviewList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
