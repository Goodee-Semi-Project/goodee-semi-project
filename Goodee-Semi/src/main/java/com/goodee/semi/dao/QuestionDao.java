package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Question;

public class QuestionDao {

	public List<Question> selectAllQuestionList() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Question> result = session.selectList("com.goodee.semi.mapper.QuestionMapper.selectAllList"); 
		session.close();
		return result;
		
	}
	
}
