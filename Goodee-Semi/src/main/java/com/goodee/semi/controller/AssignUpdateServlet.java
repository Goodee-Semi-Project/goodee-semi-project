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

import com.goodee.semi.dto.Assign;
import com.goodee.semi.service.AssignService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/assign/update")
public class AssignUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AssignService service = new AssignService();
       
    public AssignUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String assignNo = request.getParameter("assignNo");
		
		Assign assign = service.selectAssign(assignNo);
		assign.setAssignStart(assign.getAssignStart().replace(" ", "T").substring(0, 16));
		assign.setAssignEnd(assign.getAssignEnd().replace(" ", "T").substring(0, 16));
		
		request.setAttribute("assign", assign);
		request.getRequestDispatcher("/WEB-INF/views/assign/update.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Assign assign = new Assign();
		assign.setAssignNo(Integer.parseInt(request.getParameter("assignNo")));
		assign.setAssignTitle(request.getParameter("assignTitle"));
		assign.setAssignContent(request.getParameter("assignContent"));
		assign.setAssignStart(request.getParameter("assignStart"));
		assign.setAssignEnd(request.getParameter("assignEnd"));
		
		Part assignPart = null;
		try {
			assignPart = request.getPart("assignImage");
		} catch (IOException | ServletException e) { e.printStackTrace(); }
		
		int result = service.updateAssignWithAttach(assign, assignPart);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "과제 수정 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "과제가 수정되었습니다.");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
