package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/delete")
public class ScheduleDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		
		int result = service.delete(schedNo);
		
		JSONObject json = new JSONObject();
		if (result != 0) {
			json.put("status", "일정 삭제 성곰");
			json.put("statusCode", "200");
		} else {
			json.put("status", "일정 삭제 실패");
			json.put("statusCode", "500");
		}
		
		response.setContentType(HttpConstants.CONTENT_TYPE_JSON);
		response.getWriter().print(json);
	}

}
