package com.goodee.semi.mapper;

import com.goodee.semi.dto.Answer;

public interface AnswerMapper {
	Answer selectOneAnswer(int questNo);
	int insertAnswer(Answer answer);
	int updateAnswer(Answer answer);
	int deleteAnswer(int questNo);
}
