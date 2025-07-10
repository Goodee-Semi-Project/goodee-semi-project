package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Question;

public class QuestionDao {

	public List<Question> selectAllQuestionList(Question param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Question> result = session.selectList("com.goodee.semi.mapper.QuestionMapper.selectAllList", param); 
		System.out.println(result);
		session.close();
		return result;
	}
	
	public Question selectOneQuest(int questNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Question result = session.selectOne("com.goodee.semi.mapper.QuestionMapper.selectOneQuest", questNo);
		session.close();
		return result;
	}
	
	public int insertQuestion(Question question) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.QuestionMapper.insertQuestion", question);
		session.close();
		return result;
	}
	
}
