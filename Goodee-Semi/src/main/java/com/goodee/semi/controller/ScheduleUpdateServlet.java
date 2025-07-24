package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

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

// TODO 수정 성공시 화면에 표시
@WebServlet("/schedule/update")
public class ScheduleUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleUpdateServlet() {
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
    
    private void sendSuccessResponse(String resCode, String resMsg, ServletResponse res) throws IOException {
		// json에 바인딩
		JSONObject json = new JSONObject();
		json.put("resCode", resCode);
		json.put("resMsg", resMsg);
		
		// 응답
		res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
		res.getWriter().print(json);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Schedule sched = null;
		
		// 1. request에 바인딩 된 값 받아오기
		try {
			int schedNo = Integer.parseInt(request.getParameter("schedNo"));
			int courseNo = Integer.parseInt(request.getParameter("courseNo"));
			int petNo = Integer.parseInt(request.getParameter("petNo"));
			int schedStep = Integer.parseInt(request.getParameter("schedStep"));
			
			String[] schedDateStr = request.getParameter("schedDate").split("-");
			LocalDate schedDate = LocalDate.of(Integer.parseInt(schedDateStr[0]), 
					Integer.parseInt(schedDateStr[1]), 
					Integer.parseInt(schedDateStr[2]));
			
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
			
			sched = new Schedule();
			sched.setSchedNo(schedNo);
			sched.setCourseNo(courseNo);
			sched.setPetNo(petNo);
			sched.setSchedStep(schedStep);
			
			sched.setSchedDate(schedDate);
			sched.setSchedStart(schedStart);
			sched.setSchedEnd(schedEnd);
		} catch (Exception e) {
    		sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
            return;
		}
		
		// 2. service 호출
		try {
			int result = service.update(sched);
			if (result != 0) {
				sendSuccessResponse("200", "일정 수정에 성공했습니다", response);
			} else {
				sendErrorResponse("500", "일정 수정에 실패했습니다", null, response);
			}
		} catch (Exception e) {
			sendErrorResponse("500", "일정 수정 중 문제가 발생했습니다: " + e.getMessage(), e, response);
		}
	}
}
