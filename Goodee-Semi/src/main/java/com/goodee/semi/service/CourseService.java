package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;

public class CourseService {
	private CourseDao courseDao = new CourseDao();

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

	public List<Course> selectList(int accountNo) {
		List<Course> list = courseDao.selectList(accountNo);
		return list;
	}

}
