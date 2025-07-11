package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Question;
import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/detail")
public class QuestionDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QuestionService service = new QuestionService();
	
    public QuestionDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questNo = Integer.parseInt( request.getParameter("no"));
		Question question = service.selectOneQuest(questNo);
		
		request.setAttribute("question", question);
		request.getRequestDispatcher("/WEB-INF/views/question/questionDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
}

