package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Assign;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.service.AssignService;

@WebServlet("/assign/listByClass")
public class AssignListByClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
  public AssignListByClassServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String classNo = request.getParameter("classNo");
		
		List<Assign> assignList = service.selectAssignListByClassNo(classNo);
		if (assignList != null && assignList.size() > 0) {
			for (Assign assign : assignList) {
				assign.setAssignSubmit(service.selectAssignSubmit(assign));
			}
		}
		
		PetClass petClass = service.selectClass(classNo);
		
		Course course = service.selectCourse(petClass.getCourseNo());
		Pet pet = service.selectPet(petClass.getPetNo());
		
		request.setAttribute("course", course);
		request.setAttribute("pet", pet);
		request.setAttribute("assignList", assignList);
		request.getRequestDispatcher("/WEB-INF/views/assign/listByClass.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
