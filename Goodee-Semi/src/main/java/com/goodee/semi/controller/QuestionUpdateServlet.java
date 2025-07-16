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

@WebServlet("/qnaBoard/questionUpdate")
public class QuestionUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QuestionService service = new QuestionService();   
	
    public QuestionUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questNo = Integer.parseInt(request.getParameter("no"));
		
		Question question = service.selectOneQuest(questNo);
		request.setAttribute("question", question);
		request.getRequestDispatcher("/WEB-INF/views/question/questionUpdate.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int questNo = Integer.parseInt(request.getParameter("questNo"));
		String questTitle = request.getParameter("questTitle");
		String questContent = request.getParameter("questContent");
		
		Question question = new Question();
		question.setQuestNo(questNo);
		question.setQuestTitle(questTitle);
		question.setQuestContent(questContent);
		
		int result = service.updateQuestion(question);
		
		JSONObject obj = new JSONObject();
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "게시글 수정이 완료되었습니다");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "게시글 수정에 실패했습니다");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

}
