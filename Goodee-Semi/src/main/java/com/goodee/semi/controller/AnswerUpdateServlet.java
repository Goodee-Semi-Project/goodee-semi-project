package com.goodee.semi.controller;

import java.io.IOException;
import java.util.Map;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.service.AnswerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qnaBoard/answerUpdate")
public class AnswerUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    AnswerService service = new AnswerService();
	
    public AnswerUpdateServlet() {
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
		
		// 질문글과 답변글 가져옴
		int questNo = Integer.parseInt(request.getParameter("no"));
		Map<String, Object> map = service.selectDetail(questNo);
		request.setAttribute("question", map.get("question"));
		request.setAttribute("answer", map.get("answer"));
		
		request.getRequestDispatcher("/WEB-INF/views/answer/answerUpdate.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int accountNo = Integer.parseInt(request.getParameter("accountNo"));
		int questNo = Integer.parseInt(request.getParameter("questNo"));
		String answerContent = request.getParameter("answerContent");
		
		int result = service.updateAnswer(accountNo, questNo, answerContent);
		
		JSONObject obj = new JSONObject();
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "답변수정이 완료되었습니다");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "등록에 실패했습니다");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

}
