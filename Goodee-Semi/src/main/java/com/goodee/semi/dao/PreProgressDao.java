package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PreProgress;

public class PreProgressDao {

	public int insertOneWithAccountNo(PreProgress preProgress) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.PreProgressMapper.insertOneWithAccountNo", preProgress);
		session.close();
		return result;
	}

	public int selectOne(PreProgress preProgress) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.goodee.semi.mapper.PreProgressMapper.selectOne", preProgress);
		session.close();
		return result;
	}

	public int update(PreProgress preProgress) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.PreProgressMapper.update", preProgress);
		session.close();
		return result;
	}

}
