package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PreTest;

public class PreTestDao {

	public int insertPreTest(SqlSession session, PreTest pt) {
		return session.insert("com.goodee.semi.mapper.PreTestMapper.insertPreTest", pt);
	}

	public List<PreTest> selectList(String preNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PreTest> list = session.selectList("com.goodee.semi.mapper.PreTestMapper.selectList", preNo);
		session.close();
		return list;
	}

	public int update(PreTest preTest) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.PreTestMapper.update", preTest);
		session.close();
		return result;
	}

}
