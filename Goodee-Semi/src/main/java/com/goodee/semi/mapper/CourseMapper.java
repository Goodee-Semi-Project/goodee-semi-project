package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public interface CourseMapper {
	int insertCourse(Course course);
	int insertAttach(Attach attach);
	int updateCourseThumb(Course course);
	List<Course> selectAllCourseByAccountNo(int accountNo);
	List<Attach> selectAllAttachByAccountNo(int accountNo);
}
