package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;

public class ClassDao {

	public int deleteClass(int classNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.ClassMapper.deleteClass", classNo);
		session.close();
		return result;
	}
	
}
