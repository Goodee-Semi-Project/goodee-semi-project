package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PetClass;

public class ClassDao {

	public int deleteClass(int classNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.ClassMapper.deleteClass", classNo);
		session.close();
		return result;
	}
	
	public PetClass selectClassByCourseNoAndPetNo(PetClass keyObj) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		PetClass petClass = session.selectOne("com.goodee.semi.mapper.ClassMapper.selectClassByCourseNoAndPetNo", keyObj);
		session.close();
		
		return petClass;
	}
	
}
