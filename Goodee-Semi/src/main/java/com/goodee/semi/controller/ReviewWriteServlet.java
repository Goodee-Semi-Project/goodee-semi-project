package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Review;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.ClassService;
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
 * Servlet implementation class ReviewWriteServlet
 */
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
	ClassService classService = new ClassService();
       
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
		HttpSession session = request.getSession(false);
		
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") != null) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		if (account != null && account.getAuthor() == 1) {
			response.sendRedirect("/invalidAccess");
			return;
		}
		
		// SJ: 어떤 과정에 대한 리뷰인지, 수강 테이블에서 가져와야 함
		List<PetClass> list = classService.selectListByAccountNo(account.getAccountNo());
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/views/review/reviewWrite.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title").trim();
		String content = request.getParameter("content").trim();
		
		String classNoStr = request.getParameter("classNo");
		int classNo = Integer.parseInt(classNoStr);
		
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
