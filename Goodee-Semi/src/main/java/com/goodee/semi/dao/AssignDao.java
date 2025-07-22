package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Assign;

public class AssignDao {

	public int insertAssign(SqlSession session, Assign assign) {
		int result = session.insert("com.goodee.semi.mapper.AssignMapper.insertAssign", assign);
		
		return result;
	}

}
