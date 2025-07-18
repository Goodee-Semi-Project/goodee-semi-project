package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.PetClass;
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
		int result = 0;
		
		if ("ADD".equals(enrollFlag)) {
			Course course = courseService.selectCourseOne(request.getParameter("courseNo"));
			
			if (course.getPetInCourseCount() < course.getCapacity()) {
				Enroll enroll = new Enroll();
				enroll.setCourseNo(Integer.parseInt(request.getParameter("courseNo")));
				enroll.setPetNo(Integer.parseInt(request.getParameter("petNo")));
				
				result = courseService.insertEnroll(enroll);
			} else {
				result = -510;
			}
		} else if (("UPDATE").equals(enrollFlag)) {
			Enroll enroll = new Enroll();
			enroll.setEnrollNo(Integer.parseInt(request.getParameter("enrollNo")));
			enroll.setEnrollStatus(request.getParameter("status").charAt(0));
			
			result = courseService.updateEnroll(enroll);
			
			if (result > 0 && enroll.getEnrollStatus() == 'Y') {
				enroll = courseService.selectEnrollOne(enroll.getEnrollNo());
				
				PetClass petClass = new PetClass();
				petClass.setCourseNo(enroll.getCourseNo());
				petClass.setPetNo(enroll.getPetNo());
				
				result = courseService.insertPetClass(petClass);
			}
		} else {
			Enroll enroll = new Enroll();
			enroll.setEnrollNo(Integer.parseInt(request.getParameter("enrollNo")));
			
			result = courseService.deleteEnroll(enroll);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "처리 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "정상적으로 처리되었습니다.");
		}
		
		if (result == -510) {
			jsonObj.put("resultCode", "510");
			jsonObj.put("resultMsg", "해당 교육과정의 정원이 가득 찼습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
