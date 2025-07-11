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

@WebServlet("/qnaBoard")
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
		
		Question param = new Question();
		
		if(keyword != null)	param.setKeyword(keyword);
		if(searchBy != null) param.setSearchBy(searchBy);
		if(orderBy != null) param.setOrderBy(orderBy);
		
		List<Question> questionList = service.selectAllQuestionList(param);
		request.setAttribute("questionList", questionList);
		request.getRequestDispatcher("/WEB-INF/views/question/qnaBoard.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
