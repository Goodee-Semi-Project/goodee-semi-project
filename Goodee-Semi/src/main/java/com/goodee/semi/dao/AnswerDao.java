package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Answer;

public class AnswerDao {

	public Answer selectOneAnswer(int questNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Answer result = session.selectOne("com.goodee.semi.mapper.AnswerMapper.selectOneAnswer", questNo);
		session.close();
		return result;
	}
	
	public int insertAnswer(Answer answer) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.AnswerMapper.insertAnswer", answer);
		session.close();
		return result;
	}
	
}
