package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attend/check")
public class AttendCheckIntervalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ScheduleService scheduleService = new ScheduleService();
	
    public AttendCheckIntervalServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		
		Schedule sched = scheduleService.selectSchedule(schedNo);
		JSONObject obj = new JSONObject();
		boolean result;
		
		// 출석여부 확인
		if(sched.getSchedAttend() == 'Y') {
			result = true;
			obj.put("attend", result);
		} else {
			result = false;
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().println(obj);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
