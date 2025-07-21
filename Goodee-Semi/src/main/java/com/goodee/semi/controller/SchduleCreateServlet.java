package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/create")
public class SchduleCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ScheduleService service = new ScheduleService();
	
    public SchduleCreateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int accountNo = Integer.parseInt(request.getParameter("accountNo"));
		 int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		 int petNo = Integer.parseInt(request.getParameter("petNo"));
		 int schedStep = Integer.parseInt(request.getParameter("schedStep"));
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
		 Schedule sched = new Schedule();
		 sched.setPetNo(petNo);
		 sched.setCourseNo(courseNo);
		 
		 int classNo = service.selectClassNo(sched);
		 
		 // TODO 일정표의 모든 기능에 차수 관련 기능 덧붙이기
		 // class_no, sched_step, sched_date, sched_start, sched_end 를 Schedule에 바인딩하여 insert함

		 sched.setClassNo(classNo);
		 sched.setSchedStep(schedStep);
		 sched.setSchedDate(date);
		 sched.setSchedStart(start);
		 sched.setSchedEnd(end);
		 
		 Schedule insertedSched = service.insert(sched);
		 
		 JSONObject json = new JSONObject();
		 DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		 DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		 if (insertedSched != null) {
			JSONObject extenedProp = new JSONObject();

			extenedProp.put("accountNo", insertedSched.getAccountNo());
			extenedProp.put("accountName", insertedSched.getAccountName());
			extenedProp.put("petNo", insertedSched.getPetNo());
			extenedProp.put("petName", insertedSched.getPetName());
			extenedProp.put("classNo", insertedSched.getClassNo());
			extenedProp.put("schedStep", insertedSched.getSchedStep());
			extenedProp.put("schedDate", insertedSched.getSchedDate().format(formatDate));
			extenedProp.put("schedAttend", String.valueOf(insertedSched.getSchedAttend())); // char타입은 String으로 변환해서 보내야 화면에서 parserror가 발생하지 않음
			extenedProp.put("courseNo", insertedSched.getCourseNo());
			extenedProp.put("courseTitle", insertedSched.getCourseTitle());
			extenedProp.put("courseTotalStep", insertedSched.getCourseTotalStep());
			
			
			json.put("extendedProps", extenedProp);
			
			json.put("id", insertedSched.getSchedNo());
			
			json.put("start", insertedSched.getSchedStart().format(formatDateTime));
			json.put("end", insertedSched.getSchedEnd().format(formatDateTime));
			
			json.put("title", "(" + insertedSched.getCourseTitle() + ") " 
					+ insertedSched.getAccountName() + "-" + insertedSched.getPetName()
					+ " " + insertedSched.getSchedStep() + "차시");
		 } else {
			 json.put("status", "일정 등록 중 문제 발샐");
			 json.put("statusCode", "500");			 
		 }
		 
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

}
