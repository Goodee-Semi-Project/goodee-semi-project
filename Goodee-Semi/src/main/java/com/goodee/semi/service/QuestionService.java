package com.goodee.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dao.AnswerDao;
import com.goodee.semi.dao.QuestionDao;
import com.goodee.semi.dto.Answer;
import com.goodee.semi.dto.Question;

public class QuestionService {
	QuestionDao questionDao = new QuestionDao();
	AnswerDao answerDao = new AnswerDao();

	public List<Question> selectAllQuestionList(Question question) {
		return questionDao.selectAllQuestionList(question);
	}
	
	public Map<String, Object> selectDetail(int questNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Question question = questionDao.selectOneQuest(questNo);
		Answer answer = answerDao.selectOneAnswer(questNo);
		map.put("question", question);
		map.put("answer", answer);
		
		return map;
	}

	public Question selectOneQuest(int questNo) {
		return questionDao.selectOneQuest(questNo);
	}
	
	public int insertQuestion(int accountNo, String questTitle, String questContent) {
		Question question = new Question();
		question.setAccountNo(accountNo);
		question.setQuestTitle(questTitle);
		question.setQuestContent(questContent);
		return questionDao.insertQuestion(question);
	}
	
	public int deleteQuestion(int questNo) {
		return questionDao.deleteQuestion(questNo);
	}
	
	public int updateQuestion(Question question) {
		return questionDao.updateQuestion(question);
	}
	
	public int selectQuestionCount(Question question) {
		return questionDao.selectQuestionCount(question);
	}
	
	
	
}
