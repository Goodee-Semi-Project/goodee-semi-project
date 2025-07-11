package com.goodee.semi.service;

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
		answer.setAccountId(answerContent);
		answer.setQuestNo(questNo);
		answer.setAnswerContent(answerContent);
		return answerDao.insertAnswer(answer);
	}
	
}
