package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

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
		
		// TODO 마저 구현
		switch (valueType) {
			case "courseNo" -> {
				int courseNo = Integer.parseInt(request.getParameter("courseNo"));
				System.out.println("courseNo: " + courseNo);
				list = service.selectAccountList(courseNo);
			}
			case "accountNo" -> {
				String accountNo = request.getParameter("accountNo");
//				list = service.selectPetList(accountNo);
				System.out.println("accountNo: " + accountNo);
			}
		}
		
		System.out.println("list: " + list);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Event event : list) {
			JSONObject prop = new JSONObject();
			prop.put("accountNo", event.getAccountNo());
			prop.put("accountName", event.getAccountName());
			
			jsonArr.add(prop);
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
