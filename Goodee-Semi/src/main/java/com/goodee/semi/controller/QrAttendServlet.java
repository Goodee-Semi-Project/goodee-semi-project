package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ClassService;
import com.goodee.semi.service.CourseService;
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
    CourseService courseService = new CourseService();
    ClassService classService = new ClassService();
	
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
		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int courseNo = Integer.parseInt(request.getParameter("courseNo"));
		
		Schedule schedule = new Schedule();
		schedule.setSchedNo(schedNo);
		schedule.setPetNo(petNo);
		schedule.setCourseNo(courseNo);
		
		// 현재 등록되어있는 출석여부를 가져옴
		Schedule didAttend = scheduleService.selectSchedule(schedNo);
		
        // 가져온 출석여부를 확인 후 결과에 따른 로직 분기
		String message = "";
        if(didAttend.getSchedAttend() == 'Y') {
        	message = "이미 출석처리 되어있습니다.";
        } else {
        	message = "출석체크완료";
        	schedule.setSchedAttend('Y');
        	scheduleService.updateScheduleAttend(schedule);
        	int currentStep = scheduleService.selectCountAttend(schedule);
        	int totalStep = courseService.selectCourseOne(request.getParameter("courseNo")).getTotalStep();
        	int currentProg = (int)((double)currentStep / totalStep * 100);
    		PetClass petClass = new PetClass();
    		petClass.setPetNo(petNo);
    		petClass.setCourseNo(courseNo);
        	petClass.setClassProg(currentProg);
        	int result = classService.updateClassProg(petClass);
        	
        }
        
		request.setAttribute("message", message);
		request.getRequestDispatcher("/WEB-INF/views/account/login.jsp").forward(request, response);
        
		
        // 교육시작시간 + 10분까지 출석등록
//		  LocalDateTime now = LocalDateTime.now();
//        LocalDateTime start = sched.getSchedStart();
//        LocalDateTime limitTime = start.plusMinutes(10);
		
		
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
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
