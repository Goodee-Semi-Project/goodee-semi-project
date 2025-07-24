package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ScheduleService service = new ScheduleService();

    public ScheduleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. session에서 accountNo 가져오기
		AccountDetail accountDetail = (AccountDetail) request.getSession(false).getAttribute("loginAccount");
		
		// 2. 페이지 이동
		try {
			// 회원인 경우
			if(accountDetail.getAuthor() == Account.MEMBER_AUTHOR) {
				request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_member.jsp").forward(request, response);
				return;
			}
			
			// 회원이 아니고 훈련사도 아닌 경우
			if(accountDetail.getAuthor() != Account.TRAINER_AUTHOR) {
				System.out.println("[ScheduleServlet] 허용되지 않는 접근");
				response.sendRedirect(request.getContextPath() + "/");
				return;
			}
			
			// 훈련사인 경우
			String petNo = request.getParameter("petNo");
			String courseNo = request.getParameter("courseNo");
			
			if(petNo == null) { // 모든 반려견의 일정을 조회하는 페이지로 이동
				// 3. 일정 등록/수정/삭제 모달에 표시할 정보를 service로부터 받아와 바인딩
				List<Schedule> courseList = service.selectCourseList(accountDetail.getAccountNo());				
				request.setAttribute("courseList", courseList);				
				request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_trainer.jsp").forward(request, response);
			} else { // 특정 반려견의 일정을 조회하는 페이지로 이동
				request.setAttribute("petNo", petNo);
				request.setAttribute("courseNo", courseNo);
				request.getRequestDispatcher("/WEB-INF/views/schedule/schedule_trainer_byPet.jsp").forward(request, response);
			}
		} catch (Exception e) {
            System.out.println("[ScheduleServlet] 페이지 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/");
		}
	}
}
