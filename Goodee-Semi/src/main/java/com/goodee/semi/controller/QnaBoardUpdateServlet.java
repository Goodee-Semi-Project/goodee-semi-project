package com.goodee.semi.controller;

import java.io.IOException;

import com.goodee.semi.dto.Question;
import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/list/update")
public class QnaBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QuestionService service = new QuestionService();   
	
    public QnaBoardUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questNo = Integer.parseInt(request.getParameter("no"));
		System.out.println("questNo: "+questNo);
		
		Question question = service.selectOneQuest(questNo);
		request.setAttribute("question", question);
		request.getRequestDispatcher("/WEB-INF/views/question/qnaBoardUpdate.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int accountNo = Integer.parseInt(request.getParameter("qnaAccountNo"));
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		
		System.out.println(accountNo);
		System.out.println(qnaTitle);
		
		
		
	}

}
