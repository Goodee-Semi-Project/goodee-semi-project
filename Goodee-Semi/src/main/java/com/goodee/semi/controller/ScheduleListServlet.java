package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// TODO dto, service 만들고 마저 구현
@WebServlet("/schedule/list")
public class ScheduleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 응답 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 바인딩 된 값 받아오기
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		System.out.println("[start]: " + start + ", [end]: " + end);
		
		// 3. 받아온 값을 map에 바인딩
		String[] startDateStr = start.substring(0, start.indexOf('T')).split("-");
		String[] endDateStr = end.substring(0, end.indexOf('T')).split("-");
		
		LocalDate startDate = LocalDate.of(Integer.parseInt(startDateStr[0]), 
										   Integer.parseInt(startDateStr[1]), 
										   Integer.parseInt(startDateStr[2]));
		LocalDate endDate = LocalDate.of(Integer.parseInt(endDateStr[0]), 
										 Integer.parseInt(endDateStr[1]), 
										 Integer.parseInt(endDateStr[2]));
		
		Map<String, LocalDate> map = new HashMap<String, LocalDate>();
		map.put("start", startDate);
		map.put("end", endDate);
		System.out.println("map: " + map);
		
		// 4. service에서 일정 리스트 데이터 받아오기
		List<Schedule> list = service.selectScheduleList(map);
		System.out.println(list);
		
		JSONObject json = new JSONObject();
		json.put("list", list);
		
		// 7. 응답 인코딩하고 보내기
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
