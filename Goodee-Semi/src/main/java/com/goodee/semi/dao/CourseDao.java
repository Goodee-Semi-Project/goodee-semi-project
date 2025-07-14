package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public class CourseDao {
	
	public List<Course> selectCourse(SqlSession session, Course course) {
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectCourse", course);
		
		return list;
	}
	
	public Attach selectThumbAttach(SqlSession session, Course course) {
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectThumbAttach", course);
		
		return attach;
	}
	
	public Attach selectInputAttach(SqlSession session, Course course) {
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectInputAttach", course);
		
		return attach;
	}

	public int insertCourse(SqlSession session, Course course) {
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertCourse", course);
		
		return result;
	}

	public int insertAttach(SqlSession session, Attach thumbAttach, Attach inputAttach) {
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertAttach", thumbAttach);
		
		if (result > 0) result = session.insert("com.goodee.semi.mapper.CourseMapper.insertAttach", inputAttach);
		
		return result;
	}

	public int updateCourseThumb(SqlSession session, Course course) {
		int result = session.update("com.goodee.semi.mapper.CourseMapper.updateCourseThumb", course);
		
		return result;
	}

	

	

	

}
