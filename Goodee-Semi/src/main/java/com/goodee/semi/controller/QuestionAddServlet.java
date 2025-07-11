package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Question;
import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/questionAdd")
public class QuestionAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionService service = new QuestionService();
	
       
    public QuestionAddServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/question/questionAddList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int qnaAccountNo = Integer.parseInt(request.getParameter("qnaAccountNo"));
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		
		Question question = new Question();
		question.setAccountNo(qnaAccountNo);
		question.setQuestTitle(qnaTitle);
		question.setQuestContent(qnaContent);
		
		int result = service.insertQuestion(question);
		
		JSONObject obj = new JSONObject();
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "게시글 등록이 완료되었습니다.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "게시글 등록에 실패했습니다.");
		}
		
		response.setContentType("application/json; charset=utf=8");
		response.getWriter().print(obj);
		
	}

}
