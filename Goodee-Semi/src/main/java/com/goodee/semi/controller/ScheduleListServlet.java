package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;

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
		request.setCharacterEncoding("UTF-8");
		
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		String[] startDate = start.substring(start.indexOf('T')).split("-");
		String[] endDate = end.substring(end.indexOf('T')).split("-");
		
		LocalDateTime startDateLdt = LocalDateTime.of(Integer.parseInt(startDate[0]), 
													  Integer.parseInt(startDate[1]), 
													  Integer.parseInt(startDate[2]),
													  0, 0, 0);
		LocalDateTime endDateLdt = LocalDateTime.of(Integer.parseInt(endDate[0]), 
													Integer.parseInt(endDate[1]), 
													Integer.parseInt(endDate[2]),
													0, 0, 0);
		
		HashMap<String, LocalDateTime> map = new HashMap<String, LocalDateTime>();
		map.put("start", startDateLdt);
		map.put("end", endDateLdt);
		
		service.selectScheduleList(map);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
