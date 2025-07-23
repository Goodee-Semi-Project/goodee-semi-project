package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.AssignSubmit;

public class AssignSubmitDao {

	public int insertAssignSubmit(SqlSession session, AssignSubmit assignSubmit) {
		int result = session.insert("com.goodee.semi.mapper.AssignSubmitMapper.insertAssignSubmit", assignSubmit);
		
		return result;
	}

}
