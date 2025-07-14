package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Review;
import com.goodee.semi.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
		
		// TODO: 첨부파일 통일화 후 추가 작성
		Review review = reviewService.selectReivewOne(reviewNo);
		Attach attach = reviewService.selectAttachByReviewNo(reviewNo);
		
		request.setAttribute("review", review);
		request.setAttribute("attach", attach);
		request.getRequestDispatcher("/WEB-INF/views/review/reviewDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// 리뷰 삭제
		String reviewNoStr = null;
		int reviewNo = -1;
		if ((reviewNoStr= request.getParameter("reviewNo")) != null) {
			reviewNo = Integer.parseInt(reviewNoStr);
		}
		
		HttpSession session = request.getSession();
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		String accountId = null;
		if (account != null && account.getAccountId() != null) {
			accountId = account.getAccountId();
		}
		
		Review review = null;
		JSONObject obj = new JSONObject();

		obj.put("res_code", "500");
		obj.put("res_msg", "잘못된 사용자 입니다.");
		
		if (accountId != null && reviewNo != -1) {
			review = reviewService.selectReivewOne(reviewNo);
			if (review.getAccountId().equals(accountId)) {
				int result = reviewService.deleteReview(reviewNo);
				
				if (result > 0) {
					obj.put("res_code", "200");
					obj.put("res_msg", "후기를 삭제합니다.");
				}
			}
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
