package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attend/detailDelete")
public class AttendDetailDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ScheduleService scheduleService = new ScheduleService();   
	
    public AttendDetailDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		
		System.out.println(schedNo);
		
		int result = scheduleService.deleteScheduleBySchedNo(schedNo);
		
		JSONObject obj = new JSONObject();
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "출석 기록을 삭제했습니다!");
		} else {
			obj.put("res_code", "200");
			obj.put("res_msg", "출석 기록을 삭제하지 못했습니다!");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
		
	}

}
