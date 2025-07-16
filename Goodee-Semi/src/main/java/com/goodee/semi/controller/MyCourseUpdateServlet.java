package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.CourseService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/myCourse/update")
public class MyCourseUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
	public MyCourseUpdateServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseNo = request.getParameter("no");
		
		Course course = courseService.selectCourseOne(courseNo);
		
		request.setAttribute("course", course);
		request.getRequestDispatcher("/WEB-INF/views/myCourse/update.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		int accountNo = Integer.parseInt(request.getParameter("trainer"));
		String title = request.getParameter("title");
		String subTitle = request.getParameter("subTitle");
		String object = request.getParameter("object");
		int totalStep = Integer.parseInt(request.getParameter("totalStep"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		String tag = request.getParameter("tag");
		
		Part thumbPart = null;
		Part inputPart = null;
		
		Course course = new Course();
		course.setCourseNo(courseNo);
		course.setAccountNo(accountNo);
		course.setTitle(title);
		course.setSubTitle(subTitle);
		course.setObject(object);
		course.setTotalStep(totalStep);
		course.setCapacity(capacity);
		course.setTag(tag);
		
		try {
			thumbPart = request.getPart("thumbImage");
			inputPart = request.getPart("inputImage");
		} catch (IOException | ServletException e) { e.printStackTrace(); }
		
		File uploadDir = AttachService.getUploadDirectory(Attach.COURSE);
		
		Attach thumbAttach = null;
		Attach inputAttach = null;
		
		if (thumbPart.getSize() > 0) {
			thumbAttach = AttachService.handleUploadFile(thumbPart, uploadDir);			
		}
		
		if (inputPart.getSize() > 0) {
			inputAttach = AttachService.handleUploadFile(inputPart, uploadDir);			
		}
		
		int result = courseService.updateCourse(course, thumbAttach, inputAttach);
		
		JSONObject jsonObj = new JSONObject();
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "교육과정이 수정되었습니다.");
		} else {
			jsonObj.put("resultCode", "500");
			jsonObj.put("resultMsg", "교육과정 수정 중 오류가 발생했습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
