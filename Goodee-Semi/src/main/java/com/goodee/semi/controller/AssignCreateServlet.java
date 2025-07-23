package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Assign;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.AssignService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/assign/create")
public class AssignCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
  public AssignCreateServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		AccountDetail account = (AccountDetail) session.getAttribute("loginAccount");
		
		if (account.getAuthor() != 1) {
			// TODO 잘못된 접근 예외처리
		}
		
		List<Course> courseList = service.selectCourseListByAccountDetail(account);
		
		request.setAttribute("courseList", courseList);
		request.getRequestDispatcher("/WEB-INF/views/assign/create.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String flag = request.getParameter("flag");
		JSONObject jsonObj = new JSONObject();
		
		if ("pet".equals(flag)) {
			String courseNo = request.getParameter("courseNo");
			List<Pet> petList = service.selectPetListByCourseNo(courseNo);
			
			JSONArray jsonArr = new JSONArray();
			for (Pet pet : petList) {
				JSONObject petObj = new JSONObject();
				petObj.put("petNo", pet.getPetNo());
				petObj.put("petName", pet.getPetName());
				
				jsonArr.add(petObj);
			}
			
			jsonObj.put("petList", jsonArr);
		} 
		
		if ("schedule".equals(flag)) {
			String courseNo = request.getParameter("courseNo");
			String petNo = request.getParameter("petNo");
			List<Schedule> scheduleList = service.selectScheduleListByCourseNoAndPetNo(courseNo, petNo);
			
			JSONArray jsonArr = new JSONArray();
			for (Schedule schedule : scheduleList) {
				JSONObject scheduleObj = new JSONObject();
				scheduleObj.put("schedNo", schedule.getSchedNo());
				scheduleObj.put("schedDate", schedule.getSchedDate().format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
				
				jsonArr.add(scheduleObj);
			}
			
			jsonObj.put("scheduleList", jsonArr);
		} 
		
		if ("save".equals(flag)) {
			String courseNo = request.getParameter("selectCourse");
			String petNo = request.getParameter("selectPet");
			
			Assign assign = new Assign();
			assign.setClassNo(service.selectClassByCourseNoAndPetNo(courseNo, petNo).getClassNo());
			assign.setSchedNo(Integer.parseInt(request.getParameter("selectSchedule")));
			assign.setAccountNo(Integer.parseInt(request.getParameter("trainer")));
			assign.setAssignTitle(request.getParameter("assignTitle"));
			assign.setAssignContent(request.getParameter("assignContent"));
			assign.setAssignStart(request.getParameter("assignStart"));
			assign.setAssignEnd(request.getParameter("assignEnd"));
			assign.setAssignReceipt('Y');
			
			Part assignPart = null;
			try {
				assignPart = request.getPart("assignImage");
			} catch (IOException | ServletException e) { e.printStackTrace(); }
			
			int result = service.insertAssignWithAttach(assign, assignPart);
			
			if (result > 0) {
				jsonObj.put("resultCode", "200");
				jsonObj.put("resultMsg", "과제가 등록되었습니다.");
			} else {
				jsonObj.put("resultCode", "500");
				jsonObj.put("resultMsg", "과제 등록 중 오류가 발생했습니다.");
			}
		}
		
		if ("submit".equals(flag)) {
			String courseNo = request.getParameter("selectCourse");
			String petNo = request.getParameter("selectPet");
			
			Assign assign = new Assign();
			assign.setClassNo(service.selectClassByCourseNoAndPetNo(courseNo, petNo).getClassNo());
			assign.setSchedNo(Integer.parseInt(request.getParameter("selectSchedule")));
			assign.setAssignTitle(request.getParameter("assignTitle"));
			assign.setAssignContent(request.getParameter("assignContent"));
			assign.setAssignStart(request.getParameter("assignStart"));
			assign.setAssignEnd(request.getParameter("assignEnd"));
			assign.setAssignReceipt('Y');
			
			Part assignPart = null;
			try {
				assignPart = request.getPart("assignImage");
			} catch (IOException | ServletException e) { e.printStackTrace(); }
			
			int result = service.insertAssignWithAttach(assign, assignPart);
			
			if (result > 0) {
				jsonObj.put("resultCode", "200");
				jsonObj.put("resultMsg", "과제가 등록되었습니다.");
			} else {
				jsonObj.put("resultCode", "500");
				jsonObj.put("resultMsg", "과제 등록 중 오류가 발생했습니다.");
			}
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
