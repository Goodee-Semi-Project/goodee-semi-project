package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Question;
import com.goodee.semi.service.AnswerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qnaBoard/answerAdd")
public class AnswerAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       AnswerService service = new AnswerService();
	
    public AnswerAddServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 권한 유효성 검사
		Account account = null;
		if(session.getAttribute("loginAccount") != null) {
			account = (Account)session.getAttribute("loginAccount");
			if(account.getAuthor() != 1) {
				response.sendRedirect(request.getContextPath()+"/WEB-INF/views/question/qnaBoardList.jsp");
				return;
			}
		}
		
		// 답변을 작성할 해당 질문글을 번호로 조회
		int questNo = Integer.parseInt(request.getParameter("no"));
		Question question = service.selectOneQuest(questNo);
		
		request.setAttribute("question", question);
		request.setAttribute("answer", null);
		request.getRequestDispatcher("/WEB-INF/views/answer/answerAdd.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int accountNo = Integer.parseInt(request.getParameter("answerAccountNo"));
		int questNo = Integer.parseInt(request.getParameter("questNo"));
		String answerContent = request.getParameter("answerContent");
		
		int result = service.insertAnswer(accountNo, questNo, answerContent);
		
		JSONObject obj = new JSONObject();
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "답변이 등록되었습니다");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "답변 등록에 실패했습니다.");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
