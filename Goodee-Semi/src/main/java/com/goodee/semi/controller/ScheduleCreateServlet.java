package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/create")
public class ScheduleCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ScheduleService service = new ScheduleService();
	
    public ScheduleCreateServlet() {
        super();
    }
    
    private void sendErrorResponse(String resCode, String resMsg, Exception e, ServletResponse res) throws IOException {
        JSONObject json = new JSONObject();
        json.put("resCode", resCode);
        json.put("resMsg", resMsg);
        
        if(e != null) {        	
        	e.printStackTrace();
        }
        
        res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
        res.getWriter().print(json);
    }
    
    private void sendSuccessResponse(String resCode, String resMsg, Schedule insertedSched, ServletResponse res) throws IOException {
		JSONObject json = new JSONObject();
		DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

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
		
		res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
		res.getWriter().print(json);
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Schedule sched = null;
		
		// 1. request에 바인딩 된 값 받아오기
		try {
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
			
			// petNo, courseNo로 classNo를 찾아옴
			sched = new Schedule();
			sched.setPetNo(petNo);
			sched.setCourseNo(courseNo);
			sched.setSchedStep(schedStep);
			sched.setSchedDate(date);
			sched.setSchedStart(start);
			sched.setSchedEnd(end);
		} catch (Exception e) {
			sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
			return;
		}
		
		// 2. service 호출해 classNo 받아와서 sched에 바인딩 후 insert 한 뒤 insert 결과 가져오기
		try {
			/*
			 * session.selectOne():
			 * MyBatis에서 resultType이 int인 경우 결과가 없으면 null이 반환되고, int로 언박싱 시 NPE 발생
			 * NPE를 방지하기 위해 selectClassNo()의 반환값을 int -> Integer 변경
			 */
			Integer classNo = service.selectClassNo(sched);
			
			if (classNo == null) {
				sendErrorResponse("400", "조회된 classNo가 없습니다", null, response);
				return;
			}
			
			sched.setClassNo(classNo);
			Schedule insertedSched = service.insert(sched);
			
			if (insertedSched == null) {
				sendErrorResponse("500", "일정 등록에 실패했습니다", null, response);
				return;
			}
			
			sendSuccessResponse("200", "일정 등록에 성공했습니다", insertedSched, response);
		} catch (Exception e) {
			sendErrorResponse("500", "일정 등록 중 문제가 발생했습니다: " + e.getMessage(), e, response);
			return;
		}
	}
}
