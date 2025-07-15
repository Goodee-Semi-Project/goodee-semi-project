package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Enroll;
import com.goodee.semi.service.CourseService;

@WebServlet("/myCourse/enroll")
public class MyCourseEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public MyCourseEnrollServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String enrollFlag = request.getParameter("enrollFlag");
		
		Enroll enroll = new Enroll();
		enroll.setCourseNo(Integer.parseInt(request.getParameter("courseNo")));
		enroll.setPetNo(Integer.parseInt(request.getParameter("petNo")));
		
		int result = 0;
		
		if ("ADD".equals(enrollFlag)) result = courseService.insertEnroll(enroll);
		else if (("UPDATE").equals(enrollFlag)) result = courseService.updateEnroll(enroll);
		else result = courseService.deleteEnroll(enroll);
		
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
