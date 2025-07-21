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

	public int update(SqlSession session, PreTest preTest) {
		int result = session.update("com.goodee.semi.mapper.PreTestMapper.update", preTest);
		return result;
	}

	public int countOne(SqlSession session, PreTest preTest) {
		int result = session.selectOne("com.goodee.semi.mapper.PreTestMapper.countOne", preTest);
		return result;
	}

	public int delete(String testNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.PreTestMapper.delete", testNo);
		session.close();
		return result;
	}

}
