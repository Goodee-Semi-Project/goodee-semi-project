package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Account;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.CourseService;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/intro")
public class IntroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService accountService = new AccountService();
	PetService petService = new PetService();
	CourseService courseService = new CourseService();	   
	
    public IntroServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 훈련소 소개 페이지에 사용할 4명의 훈련사 조회
		List<Account> accountList = accountService.selectAccountTrainer4();
		int totalPetNum = petService.countTotalPetNo();
		int totalCourseNum = courseService.countTotalClassNo();
		int totalAccountNum = accountService.countTotalAccountNo();
		
		request.setAttribute("totalAccountNum", totalAccountNum);
		request.setAttribute("accountList", accountList);
		request.setAttribute("totalPetNum", totalPetNum);
		request.setAttribute("totalCourseNum", totalCourseNum);
		request.getRequestDispatcher("/WEB-INF/views/info/intro.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
