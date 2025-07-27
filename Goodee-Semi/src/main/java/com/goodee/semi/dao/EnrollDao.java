package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;

public class EnrollDao {
	public int updateEnrollByPetNo(int petNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.EnrollMapper.updateEnrollByPetNo", petNo);
		session.close();
		return result;
	}
}
