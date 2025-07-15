package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PreCourse;

public class PreCourseDao {

	public List<PreCourse> selectList(int courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<PreCourse> list = session.selectList("com.goodee.semi.mapper.PreCourseMapper.selectList", courseNo);
		session.close();
		return list;
	}

	public int insertPreCourse(SqlSession session, PreCourse preCourse) {
		return session.insert("com.goodee.semi.mapper.PreCourseMapper.insertPreCourse", preCourse);
	}

	public int insertAttach(SqlSession session, Attach attach) {
		int result = session.insert("com.goodee.semi.mapper.PreCourseMapper.insertAttach", attach);
		return result;
	}

	public PreCourse selectPreCourse(int preNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		PreCourse preCourse = session.selectOne("com.goodee.semi.mapper.PreCourseMapper.selectPreCourse", preNo);
		session.close();
		return preCourse;
	}

}
