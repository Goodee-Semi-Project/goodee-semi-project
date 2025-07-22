package com.goodee.semi.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/input")
public class ScheduleInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleInputServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String valueType = request.getParameter("valueType");
		Schedule sched = new Schedule();
		List<Schedule> list = null;
		Integer schedStep = null;
		JSONArray jsonArr = new JSONArray();
		
		switch (valueType) {
			case "courseNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				list = service.selectAccountList(courseNo);
				
				for(Schedule s : list) {
					JSONObject prop = new JSONObject();
					prop.put("accountNo", s.getAccountNo());
					prop.put("accountName", s.getAccountName());
					
					jsonArr.add(prop);
				}
			}
			case "accountNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				int accountNo = Integer.parseInt(request.getParameter("accountNo"));
				sched.setCourseNo(courseNo);
				sched.setAccountNo(accountNo);
				list = service.selectPetList(sched);
				
				for(Schedule s : list) {
					JSONObject prop = new JSONObject();
					prop.put("petNo", s.getPetNo());
					prop.put("petName", s.getPetName());
					
					jsonArr.add(prop);
				}
			}
			case "petNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				int petNo = Integer.parseInt(request.getParameter("petNo"));
				sched.setCourseNo(courseNo);
				sched.setPetNo(petNo);
				schedStep = service.selectSchedStep(sched);
				
				JSONObject prop = new JSONObject();
				prop.put("schedStep", schedStep + 1);
				
				jsonArr.add(prop);
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("jsonArr", jsonArr);
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
