package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.Like;

public class CourseService {
	private CourseDao courseDao = new CourseDao();
	
	public Course selectCourseOne(String courseNo) {
		Course course = courseDao.selectCourseOne(courseNo);
		
		Attach thumbAttach = courseDao.selectThumbAttach(course);
		Attach inputAttach = courseDao.selectInputAttach(course);
		
		course.setThumbAttach(thumbAttach);
		course.setInputAttach(inputAttach);
		
		return course;
	}
	
	public List<Course> selectCourse(Course course) {
		List<Course> courseList = courseDao.selectCourse(course);
		
		for (Course cs : courseList) {
			Attach thumbAttach = courseDao.selectThumbAttach(cs);
			Attach inputAttach = courseDao.selectInputAttach(cs);
			
			cs.setThumbAttach(thumbAttach);
			cs.setInputAttach(inputAttach);
		}
		
		return courseList;
	}

	public int insertCourse(Course course, Attach thumbAttach, Attach inputAttach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = courseDao.insertCourse(session, course);
			
			if (result > 0) {
				thumbAttach.setTypeNo(Attach.COURSE);
				inputAttach.setTypeNo(Attach.COURSE);
				
				thumbAttach.setPkNo(course.getCourseNo());
				inputAttach.setPkNo(course.getCourseNo());
				
				result = courseDao.insertAttach(session, thumbAttach, inputAttach);
			}
			
			if (result > 0) {
				course.setThumb(thumbAttach.getAttachNo());
				result = courseDao.updateCourseThumb(session, course);
			}
			
			if (result > 0) session.commit();
			else session.rollback();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public int insertLike(Like like) {
		return courseDao.insertLike(like);
	}

	public int deleteLike(Like like) {
		return courseDao.deleteLike(like);
	}

	public int insertEnroll(Enroll enroll) {
		return courseDao.insertEnroll(enroll);
	}

	public int updateEnroll(Enroll enroll) {
		return courseDao.updateEnroll(enroll);
	}

	public int deleteEnroll(Enroll enroll) {
		return courseDao.deleteEnroll(enroll);
	}
	
}
