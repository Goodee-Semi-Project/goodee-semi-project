package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Question;

public interface QuestionMapper {

	List<Question> selectAllList(Question param);
	
	Question selectOneQuest(int questNo);
	
	int insertQuestion(Question question);
	
	int deleteQuestion(int questNo);
	
	int updateQuestion(Question question);
	
}
