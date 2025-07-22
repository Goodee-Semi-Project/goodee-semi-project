package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import org.checkerframework.checker.units.qual.s;

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
		
		Schedule schedule = new Schedule();
		schedule.setCourseNo(courseNo);
		schedule.setPetNo(petNo);
		
		List<Schedule> scheduleList = scheduleService.selectScheduleListAttend(schedule);
		Attach petAttach = petService.selectAttachByPetNo(petNo);
		
		if(scheduleList.size() == 0) {
			scheduleList = null;
		}
		
		request.setAttribute("scheduleList", scheduleList);
		request.setAttribute("petAttach", petAttach);
		request.getRequestDispatcher("/WEB-INF/views/attend/attendDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
