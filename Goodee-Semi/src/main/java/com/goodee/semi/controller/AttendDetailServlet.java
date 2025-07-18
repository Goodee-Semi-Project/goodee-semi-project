package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Event;
import com.goodee.semi.service.EventService;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attend/detail")
public class AttendDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    EventService eventService = new EventService();    
    PetService petService = new PetService();
	
    public AttendDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int courseNo= Integer.parseInt(request.getParameter("courseNo"));
		
		Event event = new Event();
		event.setCourseNo(courseNo);
		event.setPetNo(petNo);
		
		System.out.println("디테일 서블릿petNo: " + petNo);
		System.out.println("디테일 서블릿courseNo:" + courseNo);
		
		List<Event> eventList = eventService.selectScheduleListAttend(event);
		Attach petAttach = petService.selectAttachByPetNo(petNo);
		
		for (Event e : eventList) {
			System.out.println("Detail 서블릿" + e);
		}
		
		
		request.setAttribute("eventList", eventList);
		request.setAttribute("petAttach", petAttach);
		request.getRequestDispatcher("/WEB-INF/views/attend/attendDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
