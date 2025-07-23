package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.AssignSubmit;
import com.goodee.semi.service.AssignService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/assign/submit/update")
public class AssignSubmitUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
  public AssignSubmitUpdateServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		AssignSubmit assignSubmit = new AssignSubmit();
		assignSubmit.setSubmitNo(Integer.parseInt(request.getParameter("submitNo")));
		assignSubmit.setAssignNo(Integer.parseInt(request.getParameter("assignNo")));
		assignSubmit.setSubmitTitle(request.getParameter("assignSubmitTitle"));
		assignSubmit.setSubmitContent(request.getParameter("assignSubmitContent"));
		
		Part submitPart = null;
		try {
			submitPart = request.getPart("assignSubmitImage");
		} catch (IOException | ServletException e) { e.printStackTrace(); }
		
		int result = service.updateAssignSubmitWithAttach(assignSubmit, submitPart);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "과제 수정 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "제출된 과제가 수정되었습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
