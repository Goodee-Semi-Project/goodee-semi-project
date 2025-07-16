package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Event;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/schedule/list")
public class ScheduleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventService service = new EventService();
       
    public ScheduleListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 응답 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2-1. session에서 accountNo 가져오기
		HttpSession session = request.getSession(false);
		AccountDetail accountDetail = (AccountDetail) session.getAttribute("loginAccount");

		
		// 2-2. 바인딩 된 값 받아오기
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
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("start", startDate.toString());
		map.put("end", endDate.toString());
		map.put("accountNo", String.valueOf(accountDetail.getAccountNo()));
		System.out.println("map: " + map);
		
		// 4. service에서 일정 리스트 데이터 받아오기
		List<Event> list = service.selectEventList(map);
		System.out.println("list: " + list);
				
		// 7. 응답 보내기
		// json-simple 라이브러리를 이용하여 List 타입을 응답하고싶다면 
		// List에 들어있는 Schedule 객체 하나하나를 JSONObject에 바인딩하여 
		// List를 JSONObject로 만들어 리턴해야 함
		// (GSon은 List -> Json 자동 파싱을 지원함)
		JSONArray jsonArr = new JSONArray();
		
		DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// format() 결과에 그대로 문자열 "T"로 넣고 싶을 때는 'T'처럼 작은따옴표로 감싸야 함
		DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		
		for (Event event : list) {

			
			JSONObject extenedProp = new JSONObject();

			extenedProp.put("accountNo", event.getAccountNo());
			extenedProp.put("accountName", event.getAccountName());
			extenedProp.put("petNo", event.getPetNo());
			extenedProp.put("petName", event.getPetName());
			extenedProp.put("classNo", event.getClassNo());
			extenedProp.put("schedStep", event.getSchedStep());
			extenedProp.put("schedDate", event.getSchedDate().format(formatDate));
			extenedProp.put("schedAttend", String.valueOf(event.getSchedAttend()));
			extenedProp.put("courseNo", event.getCourseNo());
			extenedProp.put("courseTitle", event.getCourseTitle());
			extenedProp.put("courseTotalStep", event.getCourseTotalStep());
			
			JSONObject prop = new JSONObject();
			
			prop.put("extendedProps", extenedProp);
			
			prop.put("id", event.getSchedNo());
			
			prop.put("start", event.getSchedStart().format(formatDateTime));
			prop.put("end", event.getSchedEnd().format(formatDateTime));
			
			prop.put("title", "(" + event.getCourseTitle() + ") " + event.getAccountName() + "-" + event.getPetName());
			
			jsonArr.add(prop);
		}
		
		// 응답으로 넘길 jsonObject
		JSONObject json = new JSONObject();
		json.put("jsonArr", jsonArr);
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(jsonArr.toJSONString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
