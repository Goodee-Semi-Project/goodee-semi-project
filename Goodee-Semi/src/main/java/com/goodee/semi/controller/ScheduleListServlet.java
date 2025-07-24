package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/schedule/list")
public class ScheduleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleListServlet() {
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
    
    private void sendSuccessResponse(String resCode, String resMsg, List<Schedule> list, ServletResponse res) throws IOException {
		/*
		 * fulcalendar의 successCallback() 함수에 데이터를 넘겨줄 때는 jsonArray 형식 등 배열의 형식을 넘겨줘야 함
		 * (ajax에서 json 으로 받아서 json.jsonArr를 successCallback()에 넘겨주려 하면 `'e' is not iterable` 이라는 이상한 에러 발생)
		 */
//    	JSONObject json = new JSONObject();
//    	json.put("resCode", resCode);
//    	json.put("resMsg", resMsg);
    	
		JSONArray jsonArr = new JSONArray();
		
		DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// format() 결과에 그대로 문자열 "T"로 넣고 싶을 때는 'T'처럼 작은따옴표로 감싸야 함
		DateTimeFormatter formatDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		
		/*
		 * json-simple 라이브러리를 이용하여 List 타입을 응답하고싶다면
		 * List에 들어있는 Schedule 객체 하나하나를 JSONObject에 바인딩하여 
		 * List를 JSONObject로 만들어 리턴해야 함 (GSon은 List -> Json 자동 파싱을 지원함)
		 */
		for (Schedule sched : list) {
			JSONObject extenedProp = new JSONObject();

			extenedProp.put("accountNo", sched.getAccountNo());
			extenedProp.put("accountName", sched.getAccountName());
			extenedProp.put("petNo", sched.getPetNo());
			extenedProp.put("petName", sched.getPetName());
			extenedProp.put("classNo", sched.getClassNo());
			extenedProp.put("schedStep", sched.getSchedStep());
			extenedProp.put("schedDate", sched.getSchedDate().format(formatDate));
			extenedProp.put("schedAttend", String.valueOf(sched.getSchedAttend())); // char타입은 String으로 변환해서 보내야 화면에서 parserror가 발생하지 않음
			extenedProp.put("courseNo", sched.getCourseNo());
			extenedProp.put("courseTitle", sched.getCourseTitle());
			extenedProp.put("courseTotalStep", sched.getCourseTotalStep());
			
			JSONObject prop = new JSONObject();
			
			prop.put("extendedProps", extenedProp);
			
			prop.put("id", sched.getSchedNo());
			
			prop.put("start", sched.getSchedStart().format(formatDateTime));
			prop.put("end", sched.getSchedEnd().format(formatDateTime));
			
			prop.put("title", "(" + sched.getCourseTitle() + ") " + sched.getAccountName() + "-" + sched.getPetName() + " " + sched.getSchedStep() + "차시");
			
			jsonArr.add(prop);
		}
		
		res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(jsonArr);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. session에서 account 정보 가져오기
		AccountDetail accountDetail = (AccountDetail) request.getSession(false).getAttribute("loginAccount");
		
		// 2. request에 바인딩 된 값 받아오기
		Map<String, String> map = new HashMap<String, String>();
		try {
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			String petNo = request.getParameter("petNo");
			
			// 3. 받아온 값을 map에 바인딩
			String[] startDateStr = start.substring(0, start.indexOf('T')).split("-");
			String[] endDateStr = end.substring(0, end.indexOf('T')).split("-");
			
			LocalDate startDate = LocalDate.of(Integer.parseInt(startDateStr[0]), 
					Integer.parseInt(startDateStr[1]), 
					Integer.parseInt(startDateStr[2]));
			LocalDate endDate = LocalDate.of(Integer.parseInt(endDateStr[0]), 
					Integer.parseInt(endDateStr[1]), 
					Integer.parseInt(endDateStr[2]));
			
			map.put("start", startDate.toString());
			map.put("end", endDate.toString());
			
			// 회원/훈련사 조회 데이터 분기
			switch(accountDetail.getAuthor()) {
				case Account.TRAINER_AUTHOR -> {
					map.put("trainerAccountNo", String.valueOf(accountDetail.getAccountNo()));
					if (petNo != null) map.put("petNo", petNo);
				} case Account.MEMBER_AUTHOR -> {
					map.put("memberAccountNo", String.valueOf(accountDetail.getAccountNo()));
				} default -> {
					sendErrorResponse("400", "허용되지 않는 접근입니다", null, response);
					return;
				}
			}
		} catch (Exception e) {
    		sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
            return;
		}
		
		// 3. service에서 일정 리스트 데이터 받아오기
		List<Schedule> list = new ArrayList<>();
		try {
			list = service.selectScheduleList(map);
			
			if (list.isEmpty()) {
				System.out.println("[ScheduleListServlet] 조회된 일정 없음");
			} else {
				System.out.println("[ScheduleListServlet] 일정 수: " + list.size());
			}
		} catch(Exception e) {
			sendErrorResponse("500", "일정 조회에 실패했습니다: " + e.getMessage(), e, response);
			return;
		}
		
		// 5. 응답 보내기
		sendSuccessResponse("200", "일정 조회에 성공했습니다", list, response);
	}
}
