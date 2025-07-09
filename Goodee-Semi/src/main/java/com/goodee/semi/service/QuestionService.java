package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.QuestionDao;
import com.goodee.semi.dto.Question;

public class QuestionService {
	QuestionDao dao = new QuestionDao();

	public List<Question> selectAllQuestionList () {
		return dao.selectAllQuestionList();
	}
	
}
