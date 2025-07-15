package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public interface CourseMapper {
	Course selectCourseOne(String courseNo);
	List<Course> selectCourse(Course course);
	Attach selectThumbAttach(Course course);
	Attach selectInputAttach(Course course);
	int insertCourse(Course course);
	int insertAttach(Attach attach);
	int updateCourseThumb(Course course);
}
