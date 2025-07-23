package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Assign;

public class AssignDao {

	public int insertAssign(SqlSession session, Assign assign) {
		int result = session.insert("com.goodee.semi.mapper.AssignMapper.insertAssign", assign);
		
		return result;
	}

	public List<Assign> selectAssignListByClassNo(int classNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Assign> result = session.selectList("com.goodee.semi.mapper.AssignMapper.selectAssignListByClassNo", classNo);
		session.close();
		
		return result;
	}

	public Assign selectAssign(int assignNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Assign result = session.selectOne("com.goodee.semi.mapper.AssignMapper.selectAssign", assignNo);
		session.close();
		
		return result;
	}

	public int updateAssign(SqlSession session, Assign assign) {
		int result = session.update("com.goodee.semi.mapper.AssignMapper.updateAssign", assign);
		
		return result;
	}

	public int deleteAssign(int assignNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.AssignMapper.deleteAssign", assignNo);
		session.close();
		
		return result;
	}

}
