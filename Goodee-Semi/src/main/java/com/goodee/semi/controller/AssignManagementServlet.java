package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Assign;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.service.AssignService;

@WebServlet("/assign/management")
public class AssignManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
  public AssignManagementServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		List<Course> courseList = service.selectCourseListByAccountDetail(account);
		
		if (courseList != null) {
			for (Course course : courseList) {
				course.setThumbAttach(service.selectThumbAttach(course));
				course.setPetList(service.selectPetListByCourseNo(String.valueOf(course.getCourseNo())));
				course.setPetInCourseCount(course.getPetList().size());
				
				for (Pet pet : course.getPetList()) {
					pet.setPetAttach(service.selectPetAttach(pet));
				}
			}
			
			request.setAttribute("courseList", courseList);
		}
		
		List<Assign> savedAssignList = service.selectSavedAssignList(account);
		if (savedAssignList != null && savedAssignList.size() > 0) {
			request.setAttribute("savedAssignList", savedAssignList);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/assign/management.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String courseNo = request.getParameter("courseNo");
		String petNo = request.getParameter("petNo");
		
		PetClass petClass = service.selectClassByCourseNoAndPetNo(courseNo, petNo);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		
		if (petClass != null) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("classNo", petClass.getClassNo());
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
