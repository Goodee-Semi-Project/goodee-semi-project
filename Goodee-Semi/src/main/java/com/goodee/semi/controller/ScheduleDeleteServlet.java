package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/delete")
public class ScheduleDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();
       
    public ScheduleDeleteServlet() {
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
		int schedNo = 0;
		
		try {
			schedNo = Integer.parseInt(request.getParameter("schedNo"));
		} catch (Exception e) {
			sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
		}
		
		try {
			int result = service.delete(schedNo);
			
			if(result != 0) {
				sendSuccessResponse("200", "일정 삭제에 성공했습니다", response);
			} else {				
				sendErrorResponse("500", "일정 삭제에 실패했습니다", null, response);
			}
		} catch (Exception e) {
			sendErrorResponse("500", "일정 삭제 중 문제가 발생했습니다: " + e.getMessage(), e, response);
		}
	}
}
