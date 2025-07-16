package com.goodee.semi.service;

import java.util.HashMap;
import java.util.Map;

import com.goodee.semi.dao.AnswerDao;
import com.goodee.semi.dao.QuestionDao;
import com.goodee.semi.dto.Answer;
import com.goodee.semi.dto.Question;

public class AnswerService {
	QuestionDao questionDao = new QuestionDao();
	AnswerDao answerDao = new AnswerDao();
	
	public Question selectOneQuest(int questNo) {
		return questionDao.selectOneQuest(questNo);
	}
	
	public int insertAnswer(int accountNo, int questNo, String answerContent) {
		Answer answer = new Answer();
		answer.setAccountNo(accountNo);
		answer.setQuestNo(questNo);
		answer.setAnswerContent(answerContent);
		return answerDao.insertAnswer(answer);
	}
	
	public Map<String, Object> selectDetail(int questNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Question question = questionDao.selectOneQuest(questNo);
		Answer answer = answerDao.selectOneAnswer(questNo);
		map.put("question", question);
		map.put("answer", answer);
		return map;
	}
	
	public int updateAnswer(int accountNo, int questNo, String answerContent) {
		Answer answer = new Answer();
		answer.setAccountNo(accountNo);
		answer.setQuestNo(questNo);
		answer.setAnswerContent(answerContent);
		return answerDao.updateAnswer(answer);
	}
	
	public int deleteAnswer(int questNo) {
		return answerDao.deleteAnswer(questNo);
	}
	
}
