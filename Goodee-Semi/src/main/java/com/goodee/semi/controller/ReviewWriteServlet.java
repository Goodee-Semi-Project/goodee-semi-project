package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

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
import jakarta.servlet.http.Part;

/**
 * Servlet implementation class ReviewWriteServlet
 */
// SJ: 첨부 파일 사이즈
@MultipartConfig (
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 5,
		maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/review/write")
public class ReviewWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewService reviewService = new ReviewService();
	AttachService attachService = new AttachService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewWriteServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 어떤 과정에 대한 리뷰인지, 수강 테이블에서 가져와야 함
		
		request.getRequestDispatcher("/WEB-INF/views/review/reviewWrite.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title").trim();
		String content = request.getParameter("content").trim();
		// SJ: 어떤 과정에 대한 리뷰인지, 수강 테이블에서 가져와야 함
		// FIXME: 임시 수강 번호
		int classNo = 1;
		
		Review review = new Review();
		review.setReviewTitle(title);
		review.setReviewContent(content);
		review.setClassNo(classNo);
		
		Part file = null;
		if (request.getPart("attach") != null) {
			file = request.getPart("attach");
		}
		
		Attach attach = null;
		if (file != null) {
			File uploadDir = attachService.getUploadDirectory(Attach.REVIEW);
			attach = attachService.handleUploadFile(file, uploadDir);
		}
		
		
		
		// 데이터베이스에 추가
		int result = -1;
		if (attach != null) {
			result = reviewService.insertReviewWithAttach(review, attach);
		} else {
			result = reviewService.insertReview(review);
		}
		
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
