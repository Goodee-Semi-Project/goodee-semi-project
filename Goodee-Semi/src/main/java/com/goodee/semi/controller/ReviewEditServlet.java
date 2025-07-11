package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Review;
import com.goodee.semi.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class ReviewEditServlet
 */
@WebServlet("/review/edit")
public class ReviewEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewService reviewService = new ReviewService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewEditServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reviewNoStr = null;
		int reviewNo = -1;
		if ((reviewNoStr= request.getParameter("no")) != null) {
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
		
		if (accountId != null && reviewNo != -1) {
			review = reviewService.selectReivewOne(reviewNo);
			if (review.getAccountId().equals(accountId)) {
				System.out.println(review);
				request.setAttribute("review", review);
			}
		}
		
		request.getRequestDispatcher("/WEB-INF/views/review/reviewEdit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		// TODO: 후기 번호 가져오기
//		int classNo = request.getParameter("classNo");
		// TODO: 어떤 과정에 대한 리뷰인지, 수강 테이블에서 가져와야 함
		
		Review review = new Review();
		review.setReviewTitle(title);
		review.setReviewContent(content);
		// FIXME: 임시 클래스
		review.setClassNo(11);
		
		// TODO: 첨부파일 클래스 논의 후 작성
		
		// 데이터베이스에 추가
		int result = reviewService.createReview(review);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "후기 등록이 완료되었습니다.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "후기 등록에 실패했습니다.");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
