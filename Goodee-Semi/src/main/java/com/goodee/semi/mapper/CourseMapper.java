package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.Like;

public interface CourseMapper {
	Course selectCourseOne(String courseNo);
	List<Course> selectCourse(Course course);
	Attach selectThumbAttach(Course course);
	Attach selectInputAttach(Course course);
	int insertCourse(Course course);
	int insertAttach(Attach attach);
	int updateCourseThumb(Course course);
	int insertLike(Like like);
	int deleteLike(Like like);
	int insertEnroll(Enroll enroll);
	int updateEnroll(Enroll enroll);
	int deleteEnroll(Enroll enroll);
}
