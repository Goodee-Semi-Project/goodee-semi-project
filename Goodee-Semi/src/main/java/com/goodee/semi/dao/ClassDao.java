package com.goodee.semi.dao;

import java.util.List;

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

	public List<PetClass> selectListByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PetClass> list = session.selectList("com.goodee.semi.mapper.ClassMapper.selectListByAccountNo", accountNo);
		session.close();
		return list;
	}
	
}
