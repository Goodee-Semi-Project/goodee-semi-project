package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PreCourse;

public class PreCourseDao {

	public List<PreCourse> selectList(int courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PreCourse> list = session.selectList("com.goodee.semi.mapper.PreCourseMapper.selectList", courseNo);
		session.close();
		return list;
	}

}
