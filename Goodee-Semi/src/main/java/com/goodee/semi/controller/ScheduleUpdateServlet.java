package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Event;
import com.goodee.semi.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/update")
public class ScheduleUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventService service = new EventService();
       
    public ScheduleUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터 받아오기
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
				
		int petNo = Integer.parseInt(request.getParameter("petNo"));

		String[] schedDateStr = request.getParameter("schedDate").split("-");
		LocalDate schedDate = LocalDate.of(Integer.parseInt(schedDateStr[0]), 
										Integer.parseInt(schedDateStr[1]), 
										Integer.parseInt(schedDateStr[2]));
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		
		String[] schedStartStr = request.getParameter("schedStart").split("T");
		LocalDateTime schedStart = LocalDateTime.of(Integer.parseInt(schedStartStr[0].split("-")[0]),
													Integer.parseInt(schedStartStr[0].split("-")[1]),
													Integer.parseInt(schedStartStr[0].split("-")[2]),
													Integer.parseInt(schedStartStr[1].split(":")[0]),
													Integer.parseInt(schedStartStr[1].split(":")[1]));
		
		String[] schedEndStr = request.getParameter("schedEnd").split("T");
		LocalDateTime schedEnd = LocalDateTime.of(Integer.parseInt(schedEndStr[0].split("-")[0]),
													Integer.parseInt(schedEndStr[0].split("-")[1]),
													Integer.parseInt(schedEndStr[0].split("-")[2]),
													Integer.parseInt(schedEndStr[1].split(":")[0]),
													Integer.parseInt(schedEndStr[1].split(":")[1]));
		
		Event event = new Event();
		event.setSchedNo(schedNo);

		event.setPetNo(petNo);

		event.setSchedDate(schedDate);
		event.setCourseNo(courseNo);
		event.setSchedStart(schedStart);
		event.setSchedEnd(schedEnd);
		
		// service 호출
		int result = service.update(event);
		
		// json에 바인딩
		JSONObject json = new JSONObject();
		if (result != 0) {
			json.put("status", "일정 수정 성공");
			json.put("statusCode", "200");
		} else {
			json.put("status", "일정 수정 실패");
			json.put("statusCode", "500");
		}
		
		// 응답
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

}
