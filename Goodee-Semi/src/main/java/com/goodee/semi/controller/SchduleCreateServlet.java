package com.goodee.semi.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Event;
import com.goodee.semi.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/create")
public class SchduleCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private EventService service = new EventService();
	
    public SchduleCreateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int accountNo = Integer.parseInt(request.getParameter("accountNo"));
		 int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		 int petNo = Integer.parseInt(request.getParameter("petNo"));
		 String[] startDateTime = request.getParameter("start").split("T");
		 LocalDateTime start = LocalDateTime.of(Integer.parseInt(startDateTime[0].split("-")[0]), 
				 								Integer.parseInt(startDateTime[0].split("-")[1]), 
				 								Integer.parseInt(startDateTime[0].split("-")[2]), 
				 								Integer.parseInt(startDateTime[1].split(":")[0]), 
				 								Integer.parseInt(startDateTime[1].split(":")[1]));
		 String[] endDateTime = request.getParameter("end").split("T");
		 LocalDateTime end = LocalDateTime.of(Integer.parseInt(endDateTime[0].split("-")[0]), 
												Integer.parseInt(endDateTime[0].split("-")[1]), 
												Integer.parseInt(endDateTime[0].split("-")[2]), 
												Integer.parseInt(endDateTime[1].split(":")[0]), 
												Integer.parseInt(endDateTime[1].split(":")[1]));
		 LocalDate date = LocalDate.of(Integer.parseInt(endDateTime[0].split("-")[0]), 
										Integer.parseInt(endDateTime[0].split("-")[1]), 
										Integer.parseInt(endDateTime[0].split("-")[2]));

		 System.out.println(accountNo + " " + courseNo + " " + petNo + " " + start + " " + end);
		 
		 // petNo, courseNo로 classNo를 찾아옴
		 Event event = new Event();
		 event.setPetNo(petNo);
		 event.setCourseNo(courseNo);
		 
		 int classNo = service.selectClassNo(event);
		 
		 // TODO 일정표의 모든 기능에 차수 관련 기능 덧붙이기
		 // class_no, sched_step, sched_date, sched_start, sched_end 를 Event에 바인딩하여 insert함

		 event.setClassNo(classNo);
		 event.setSchedStep(0);
		 event.setSchedDate(date);
		 event.setSchedStart(start);
		 event.setSchedEnd(end);
		 
		 Event insertedEvent = service.insert(event);
		 
		 JSONObject json = new JSONObject();
		 DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		 DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		 if (insertedEvent != null) {
			JSONObject extenedProp = new JSONObject();

			extenedProp.put("accountNo", insertedEvent.getAccountNo());
			extenedProp.put("accountName", insertedEvent.getAccountName());
			extenedProp.put("petNo", insertedEvent.getPetNo());
			extenedProp.put("petName", insertedEvent.getPetName());
			extenedProp.put("classNo", insertedEvent.getClassNo());
			extenedProp.put("schedStep", insertedEvent.getSchedStep());
			extenedProp.put("schedDate", insertedEvent.getSchedDate().format(formatDate));
			extenedProp.put("schedAttend", String.valueOf(insertedEvent.getSchedAttend())); // char타입은 String으로 변환해서 보내야 화면에서 parserror가 발생하지 않음
			extenedProp.put("courseNo", insertedEvent.getCourseNo());
			extenedProp.put("courseTitle", insertedEvent.getCourseTitle());
			extenedProp.put("courseTotalStep", insertedEvent.getCourseTotalStep());
			
			
			json.put("extendedProps", extenedProp);
			
			json.put("id", insertedEvent.getSchedNo());
			
			json.put("start", insertedEvent.getSchedStart().format(formatDateTime));
			json.put("end", insertedEvent.getSchedEnd().format(formatDateTime));
			
			json.put("title", "(" + insertedEvent.getCourseTitle() + ") " + insertedEvent.getAccountName() + "-" + insertedEvent.getPetName());
		 } else {
			 json.put("status", "일정 등록 중 문제 발샐");
			 json.put("statusCode", "500");			 
		 }
		 
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

}
