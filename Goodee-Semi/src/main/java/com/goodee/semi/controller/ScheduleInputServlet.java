package com.goodee.semi.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.goodee.semi.dto.Event;
import com.goodee.semi.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/input")
public class ScheduleInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventService service = new EventService();
       
    public ScheduleInputServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String valueType = request.getParameter("valueType");
		List<Event> list = null;
		JSONArray jsonArr = new JSONArray();
		
		// TODO 마저 구현
		switch (valueType) {
			case "courseNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				System.out.println("courseNo: " + courseNo);
				list = service.selectAccountList(courseNo);
				
				System.out.println("list: " + list);
				
				for(Event event : list) {
					JSONObject prop = new JSONObject();
					prop.put("accountNo", event.getAccountNo());
					prop.put("accountName", event.getAccountName());
					
					jsonArr.add(prop);
				}
			}
			case "accountNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				int accountNo = Integer.parseInt(request.getParameter("accountNo"));
				System.out.println("courseNo: " + courseNo);
				System.out.println("accountNo: " + accountNo);
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("courseNo", courseNo);
				map.put("accountNo", accountNo);
				list = service.selectPetList(map);
				
				for(Event event : list) {
					JSONObject prop = new JSONObject();
					prop.put("petNo", event.getPetNo());
					prop.put("petName", event.getPetName());
					
					jsonArr.add(prop);
				}
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("jsonArr", jsonArr);
		System.out.println(json.toJSONString());
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
