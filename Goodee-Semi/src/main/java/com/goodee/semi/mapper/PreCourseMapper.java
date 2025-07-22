package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PreCourse;

public interface PreCourseMapper {
	List<PreCourse> selectList(int courseNo);
	int insertPreCourse(SqlSession session, PreCourse preCourse);
	int insertAttach(SqlSession session, Attach attach);
	PreCourse selectPreCourse(int preNo);
	Attach selectAttach(int preNo);
	int updatePreCourse(SqlSession session, PreCourse preCourse);
	int deleteAttach(SqlSession session, Attach attach);
	int deleteOne(SqlSession session, int preNo);
}
