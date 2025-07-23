package com.goodee.semi.controller;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.PetService;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attend/detail")
public class AttendDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ScheduleService scheduleService = new ScheduleService();    
    PetService petService = new PetService();
	
    public AttendDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int courseNo= Integer.parseInt(request.getParameter("courseNo"));
		String courseTitle = request.getParameter("courseTitle");
		
		Schedule schedule = new Schedule();
		schedule.setCourseNo(courseNo);
		schedule.setPetNo(petNo);
		
		List<Schedule> scheduleList = scheduleService.selectScheduleListAttend(schedule);
		Attach petAttach = petService.selectAttachByPetNo(petNo);
		
		// 출석 기록이 없을 경우
		if(scheduleList.size() == 0) {
			scheduleList = null;
		}
		
		// 교육진행시간 문자열 리스트로 변환
		if(scheduleList != null) {
			List<String> startEndList = new ArrayList<>();
			DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
			for (Schedule s : scheduleList) {
				String start = s.getSchedStart().format(timeFmt);
				String end = s.getSchedEnd().format(timeFmt);
				startEndList.add(start + " ~ <br>" + end);
			}
			request.setAttribute("startEndList", startEndList);
		}
		
		request.setAttribute("courseTitle", courseTitle);
		request.setAttribute("scheduleList", scheduleList);
		request.setAttribute("petAttach", petAttach);
		request.getRequestDispatcher("/WEB-INF/views/attend/attendDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
