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
		List<Schedule> list = null;
		JSONArray jsonArr = new JSONArray();
		
		switch (valueType) {
			case "courseNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				list = service.selectAccountList(courseNo);
				
				
				for(Schedule sched : list) {
					JSONObject prop = new JSONObject();
					prop.put("accountNo", sched.getAccountNo());
					prop.put("accountName", sched.getAccountName());
					
					jsonArr.add(prop);
				}
			}
			case "accountNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				int accountNo = Integer.parseInt(request.getParameter("accountNo"));
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("courseNo", courseNo);
				map.put("accountNo", accountNo);
				list = service.selectPetList(map);
				
				for(Schedule sched : list) {
					JSONObject prop = new JSONObject();
					prop.put("petNo", sched.getPetNo());
					prop.put("petName", sched.getPetName());
					
					jsonArr.add(prop);
				}
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
