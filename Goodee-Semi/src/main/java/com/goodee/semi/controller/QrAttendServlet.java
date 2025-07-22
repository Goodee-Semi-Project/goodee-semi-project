package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qr/attend")
public class QrAttendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ScheduleService scheduleService = new ScheduleService(); 
	
    public QrAttendServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 토큰 검증
//		String token = request.getParameter("token");
//		if(!"qwe123".equals(token)) {
//			response.sendError(HttpServletResponse.SC_FORBIDDEN, "유효하지 않은 접근입니다");
//			return;
//		}
		
		int schedNo = Integer.parseInt(request.getParameter("schedNo"));
		Schedule sched = scheduleService.selectSchedule(schedNo);
		System.out.println(sched);
		
		LocalDateTime now = LocalDateTime.now();
        LocalDateTime start = sched.getSchedStart();
        LocalDateTime limitTime = start.plusMinutes(10);
		
//		String message;
//		if (sched.getSchedAttend() == 'Y') {
//			message = "이미 출석 처리되었습니다";
//		} else if (now.isBefore(start) || now.isAfter(limitTime)) {
//			message = "출석 가능한 시간이 아닙니다";
//		} else {
//			sched.setSchedAttend('Y');
//			int result = scheduleService.updateScheduleAttend(sched);
//			if (result > 0) {
//				message = "출석이 완료되었습니다";
//			} else {
//				message = "출석 처리 중 오류가 발생했습니다";
//			}
//			request.setAttribute("sched", sched);
//		}
		
        sched.setSchedAttend('Y');
        int result = scheduleService.updateScheduleAttend(sched);
        
        String message;
        if(result > 0) {
        	message = "출석체크완료";
        } else {
        	message = "출석체크실패";
        }
        
		request.setAttribute("message", message);
		request.getRequestDispatcher("/WEB-INF/views/account/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
