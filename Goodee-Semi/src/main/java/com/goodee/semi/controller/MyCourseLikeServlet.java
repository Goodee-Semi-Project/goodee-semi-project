package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Like;
import com.goodee.semi.service.CourseService;

@WebServlet("/myCourse/like")
public class MyCourseLikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public MyCourseLikeServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String likeFlag = request.getParameter("likeFlag");
		
		Like like = new Like();
		like.setAccountNo(Integer.parseInt(request.getParameter("accountNo")));
		like.setCourseNo(Integer.parseInt(request.getParameter("courseNo")));
		
		int result = 0;
		
		if ("ADD".equals(likeFlag)) result = courseService.insertLike(like);
		else result = courseService.deleteLike(like);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "처리 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "정상적으로 처리되었습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
