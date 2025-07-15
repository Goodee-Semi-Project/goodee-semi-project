package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public class CourseDao {
	
	public Course selectCourseOne(String courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Course course = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectCourseOne", courseNo);
		session.close();
		
		return course;
	}
	
	public List<Course> selectCourse(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectCourse", course);
		session.close();
		
		return list;
	}
	
	public Attach selectThumbAttach(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectThumbAttach", course);
		session.close();
		
		return attach;
	}
	
	public Attach selectInputAttach(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectInputAttach", course);
		session.close();
		
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

	public List<Course> selectList(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectList", accountNo);
		session.close();
		return list;
	}

}
