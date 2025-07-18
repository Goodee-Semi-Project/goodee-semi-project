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

@WebServlet("/attend/detailUpdate")
public class AttendDetailUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ScheduleService scheduleService = new ScheduleService();
       
    public AttendDetailUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String didAttend = request.getParameter("didAttend");
		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		
		char attend;
		if(didAttend.equalsIgnoreCase("Y")) {
			attend = 'N';
		} else {
			attend = 'Y';
		}
		
		Schedule sched = new Schedule();
		sched.setSchedAttend(attend);
		sched.setPetNo(petNo);
		sched.setCourseNo(courseNo);
		sched.setSchedNo(schedNo);
		
		int result = scheduleService.updateScheduleAttend(sched);
		
		JSONObject obj = new JSONObject();
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "수정되었습니다!");
		} else {
			obj.put("res_code", "500");
			obj.put("res_code", "수정에 실패했습니다!");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
