package com.goodee.semi.controller;

import java.io.IOException;
import java.util.Map;

import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/questionDelete")
public class QuestionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QuestionService service = new QuestionService();   
	
    public QuestionDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questNo = Integer.parseInt(request.getParameter("no"));

		int result;
		
		Map<String, Object> map =  service.selectDetail(questNo);
		if(map.get("answer") != null) {
			result = -1;
			response.setContentType("text/plain; charset=utf-8");
			response.getWriter().println(result);
			return;
		}
		
		result = service.deleteQuestion(questNo);
		
		response.setContentType("text/plain; charset=utf-8");
		response.getWriter().println(result);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
