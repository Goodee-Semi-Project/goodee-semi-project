package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.PreCourse;

public interface PreCourseMapper {
	List<PreCourse> selectList(int courseNo);
}
