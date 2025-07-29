package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PetClass;

public class EnrollDao {
	public int updateEnrollByPetNo(PetClass petClass) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.EnrollMapper.updateEnrollByPetNo", petClass);
		session.close();
		return result;
	}
}
