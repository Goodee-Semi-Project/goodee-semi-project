package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.PetClass;

public class ClassDao {

	public int deleteClass(int classNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.ClassMapper.deleteClass", classNo);
		session.close();
		return result;
	}

	public List<PetClass> selectListByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PetClass> list = session.selectList("com.goodee.semi.mapper.ClassMapper.selectListByAccountNo", accountNo);
		session.close();
		return list;
	}
	
	public PetClass selectClassByCourseNoAndPetNo(PetClass keyObj) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		PetClass petClass = session.selectOne("com.goodee.semi.mapper.ClassMapper.selectClassByCourseNoAndPetNo", keyObj);
		session.close();
		
		return petClass;
	}

	public List<PetClass> selectClassListByAccountDetail(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PetClass> result = session.selectList("com.goodee.semi.mapper.ClassMapper.selectClassListByAccountDetail", account);
		session.close();
		
		return result;
	}
	
}
