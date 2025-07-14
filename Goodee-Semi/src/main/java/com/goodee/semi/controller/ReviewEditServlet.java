package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Review;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Servlet implementation class ReviewEditServlet
 */
//CARE: 첨부 파일 사이즈
@MultipartConfig (
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 5,
		maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/review/edit")
public class ReviewEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewService reviewService = new ReviewService();
	AttachService attachService = new AttachService();
       
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
		Attach attach = null;
		
		if (accountId != null && reviewNo != -1) {
			review = reviewService.selectReivewOne(reviewNo);
			attach = reviewService.selectAttachByReviewNo(reviewNo);
			
			if (review.getAccountId().equals(accountId)) {
				request.setAttribute("review", review);
				request.setAttribute("attach", attach);
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
		String reviewNoStr = null;
		int reviewNo = -1;
		if ((reviewNoStr = request.getParameter("reviewNo")) != null) {
			reviewNo = Integer.parseInt(reviewNoStr);
		}
		
		// TODO: 첨부 파일을 새로 등록하면 기존것 지우고 바꾸기
		// FIXME: 첨부 파일이 없는 게시물에 수정으로 첨부파일을 등록하면 에러 발생
		Attach attach = null;
		Part file = null;
		if ((file = request.getPart("attach")) != null) {
			File uploadDir = attachService.getUploadDirectory(Attach.REVIEW);
			attach = attachService.handleUploadFile(file, uploadDir);
		}
		
		// TODO: 어떤 과정에 대한 리뷰인지, 수강 테이블에서 가져와야 함
//		String classNoStr = null;
//		int classNo = -1;
//		if ((classNoStr = request.getParameter("classNo")) != null) {
//			classNo = Integer.parseInt(request.getParameter("classNo"));
//		}
		
		Review review = new Review();
		review.setReviewNo(reviewNo);
		review.setReviewTitle(title);
		review.setReviewContent(content);
		// FIXME: 임시 클래스
//		review.setClassNo(11);
		
		// TODO: 첨부파일 클래스 논의 후 작성
		
		// 데이터베이스에 추가
		int result = -1;
		if (attach != null) {
			result = reviewService.updateReviewWithAttach(review, attach);
		} else {
			result = reviewService.updateReview(review);
		}
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "후기 수정이 완료되었습니다.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "후기 수정에 실패했습니다.");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
