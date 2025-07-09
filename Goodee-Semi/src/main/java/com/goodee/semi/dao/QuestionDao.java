package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Question;

public class QuestionDao {

	public List<Question> selectAllQuestionList() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		System.out.println("다오");
		List<Question> result = session.selectList("com.goodee.semi.mapper.QuestionMapper.selectAllList"); 
		System.out.println(result);
		session.close();
		return result;
	}
	
	public Question selectOne() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		System.out.println("하나 호출");
		Question result = session.selectOne("com.goodee.semi.mapper.QuestionMapper.selectOne");
		session.close();
		return result;
	}
	
}
