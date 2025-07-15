package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.PreCourse;

public interface PreCourseMapper {
	List<PreCourse> selectList(int courseNo);
	int insertPreCourse(SqlSession session, PreCourse preCourse);
}
