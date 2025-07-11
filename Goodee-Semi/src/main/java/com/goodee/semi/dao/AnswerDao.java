package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Answer;

public class AnswerDao {

	public Answer selectOneAnswer(int questNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Answer result = session.selectOne("com.goodee.semi.mapper.AnswerMapper.selectOneAnswer", questNo);
		System.out.println("AnswerDao불러옴:" + result);
		session.close();
		return result;
	}
	
}
