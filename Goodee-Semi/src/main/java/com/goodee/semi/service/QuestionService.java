package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.QuestionDao;
import com.goodee.semi.dto.Question;

public class QuestionService {
	QuestionDao dao = new QuestionDao();

	public List<Question> selectAllQuestionList(Question param) {
		return dao.selectAllQuestionList(param);
	}

	public Question selectOneQuest(int questNo) {
		return dao.selectOneQuest(questNo);
	}
	
	public int insertQuestion(Question question) {
		return dao.insertQuestion(question);
	}
	
	public int deleteQuestion(int questNo) {
		return dao.deleteQuestion(questNo);
	}
	
}
