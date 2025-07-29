package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Question;
import com.goodee.semi.service.QuestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaBoard/list")
public class QnaBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuestionService service = new QuestionService();
       
    public QnaBoardListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String keyword = request.getParameter("keyword");
		String searchBy = request.getParameter("searchBy");
		String orderBy= request.getParameter("orderBy");
		
		Question question = new Question();
		
		int nowPage = 1; 
		
		question.setKeyword(keyword);
		question.setSearchBy(searchBy);
		question.setOrderBy(orderBy);
		
		String nowPageStr = request.getParameter("nowPage");
		if(nowPageStr != null) {
			nowPage = Integer.parseInt(nowPageStr);
		}
		question.setNowPage(nowPage);
		
		int totalData = service.selectQuestionCount(question);
		question.setTotalData(totalData);
		
		// 날짜의 YY-mm-HH 부분추출
		List<Question> questionList = service.selectAllQuestionList(question);
		for (Question q : questionList) {
			q.setQuestReg(q.getQuestReg().substring(0,10));
		}
		
		request.setAttribute("question", question);
		request.setAttribute("questionList", questionList);
		request.getRequestDispatcher("/WEB-INF/views/question/qnaBoardList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
