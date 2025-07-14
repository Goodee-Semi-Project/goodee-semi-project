package com.goodee.semi.mapper;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public interface CourseMapper {
	int insertCourse(Course course);
	int insertAttach(Attach attach);
	int updateCourseThumb(Course course);
}
