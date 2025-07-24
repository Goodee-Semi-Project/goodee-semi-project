package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.AssignSubmit;

public class AssignSubmitDao {

	public int insertAssignSubmit(SqlSession session, AssignSubmit assignSubmit) {
		int result = session.insert("com.goodee.semi.mapper.AssignSubmitMapper.insertAssignSubmit", assignSubmit);
		
		return result;
	}

	public AssignSubmit selectAssignSubmitByAssignNo(int assignNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		AssignSubmit result = session.selectOne("com.goodee.semi.mapper.AssignSubmitMapper.selectAssignSubmitByAssignNo", assignNo);
		session.close();
		
		return result;
	}

	public int updateAssignSubmit(SqlSession session, AssignSubmit assignSubmit) {
		int result = session.update("com.goodee.semi.mapper.AssignSubmitMapper.updateAssignSubmit", assignSubmit);
		
		return result;
	}

	public int deleteAssignSubmit(int submitNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.AssignSubmitMapper.deleteAssignSubmit", submitNo);
		session.close();
		
		return result;
	}

}
