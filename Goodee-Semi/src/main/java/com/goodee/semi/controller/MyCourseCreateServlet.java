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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
@WebServlet("/myCourse/create")
public class MyCourseCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseService courseService = new CourseService();
       
  public MyCourseCreateServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/myCourse/create.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int result = 0;
		
		int accountNo = Integer.parseInt(request.getParameter("trainer"));
		String title = request.getParameter("title");
		String subTitle = request.getParameter("subTitle");
		String object = request.getParameter("object");
		int totalStep = Integer.parseInt(request.getParameter("totalStep"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		String tag = request.getParameter("tag");
		
		List<String> tagList = Arrays.asList(tag.split(" "));
		Set<String> tagSet = new HashSet<String>(tagList);
		List<String> tagListAfterSet = new ArrayList<String>(tagSet);
		
		if (tagList.size() == tagListAfterSet.size()) {
			Part thumbPart = null;
			Part inputPart = null;
			
			Course course = new Course();
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
			
			Attach thumbAttach = AttachService.handleUploadFile(thumbPart, uploadDir);
			Attach inputAttach = AttachService.handleUploadFile(inputPart, uploadDir);
			
			result = courseService.insertCourse(course, thumbAttach, inputAttach);
		} else {
			result = -510;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "교육과정 등록 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "교육과정이 등록되었습니다.");
		} else if (result == -510) {
			jsonObj.put("resultCode", "510");
			jsonObj.put("resultMsg", "중복된 태그는 입력할 수 없습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
