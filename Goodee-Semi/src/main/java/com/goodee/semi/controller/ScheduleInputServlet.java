package com.goodee.semi.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.common.util.GsonUtil;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/input")
public class ScheduleInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleInputServlet() {
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
    	// 응답 객체 생성
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("resCode", resCode);
        responseMap.put("resMsg", resMsg);
        responseMap.put("list", list);
        
        // Gson으로 전체를 JSON 문자열로 변환
        String jsonString = GsonUtil.toJson(responseMap);
    	
    	res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(jsonString);
    }
    
    private void sendSuccessResponse(String resCode, String resMsg, Integer nextSchedStep, ServletResponse res) throws IOException {
    	JSONObject json = new JSONObject();
    	json.put("resCode", resCode);
    	json.put("resMsg", resMsg);
    	
    	json.put("schedStep", nextSchedStep);
    	
    	res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(json);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Schedule sched = new Schedule();
		List<Schedule> list = null;
		int nextSchedStep = 1;
		
		try {
			String valueType = request.getParameter("valueType");
			
			switch (valueType) {
				case "courseNo" -> {
					int courseNo = Integer.parseInt(request.getParameter("courseNo"));
					list = service.selectAccountList(courseNo);
				}
				case "accountNo" -> {
					int courseNo = Integer.parseInt(request.getParameter("courseNo"));
					int accountNo = Integer.parseInt(request.getParameter("accountNo"));
					sched.setCourseNo(courseNo);
					sched.setAccountNo(accountNo);
					list = service.selectPetList(sched);
				}
				case "petNo" -> {
					int courseNo = Integer.parseInt(request.getParameter("courseNo"));
					int petNo = Integer.parseInt(request.getParameter("petNo"));
					String schedNoStr = request.getParameter("schedNo");
					int schedNo = -1;
					if (schedNoStr != null && schedNoStr != "") {
						schedNo = Integer.parseInt(schedNoStr);
					}

					sched.setCourseNo(courseNo);
					sched.setPetNo(petNo);
					sched.setSchedNo(schedNo);
					
					Schedule overlapSched = service.selectScheduleOne(sched);
					
					Integer schedStep = service.selectSchedStep(sched);

					// 1) 현재 스케줄이 이전 스케줄과 교육과정, 반려견이 같다면 차수를 1 증가시키지 않음
					if(overlapSched != null) {
						if(schedStep == null) {
							nextSchedStep = 1;
						} else {
							nextSchedStep = schedStep;
						}
						
					}
					// 2) 현재 스케줄이 이전 스케줄과 교육과정, 반려견이 다르다면 차수를 1 증가시킴
					if(overlapSched == null) {
						// 다음 차시 계산
						if(schedStep == null) {
							nextSchedStep = 1;
						} else {
							nextSchedStep = schedStep + 1;
						}
					}
				}
				default -> {
					sendErrorResponse("400", "잘못된 valueType입니다", null, response);
					return;
				}
			}
			
		} catch (Exception e) {
			sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
            return;
		}
		
		if (list != null) {
			sendSuccessResponse("200", "일정표 모달의 선택란 데이터 전송에 성공했습니다", list, response);
		} else {
			sendSuccessResponse("200", "일정표 모달의 선택란 데이터 전송에 성공했습니다", nextSchedStep, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
