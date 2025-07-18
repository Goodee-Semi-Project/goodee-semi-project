package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.PreTest;

public class PreTestDao {

	public int insertPreTest(SqlSession session, PreTest pt) {
		return session.insert("com.goodee.semi.mapper.PreTestMapper.insertPreTest", pt);
	}

}
