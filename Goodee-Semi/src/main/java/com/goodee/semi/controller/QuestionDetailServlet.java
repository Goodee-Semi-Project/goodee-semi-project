package com.goodee.semi.controller;

import java.io.IOException;
import java.util.Map;

import com.goodee.semi.dto.Answer;
import com.goodee.semi.dto.Question;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/detail")
public class QuestionDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QuestionService questionService = new QuestionService();
    AccountService accountService = new AccountService();
	
    public QuestionDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questNo = Integer.parseInt(request.getParameter("no"));
		Map<String, Object> result= questionService.selectDetail(questNo);
		Question question = (Question)result.get("question");
		Answer answer= (Answer)result.get("answer");
		if(answer != null) {
			answer.setProfileAttach(accountService.selectAttachByAccountNo(answer.getAccountNo()));
		}
		
		request.setAttribute("question", question);
		request.setAttribute("answer", answer);
		request.getRequestDispatcher("/WEB-INF/views/question/questionDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
}

