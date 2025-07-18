package com.goodee.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.PreCourseDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.PreCourse;

public class PreCourseService {
	PreCourseDao preCourseDao = new PreCourseDao();

	public Map<Integer, List<PreCourse>> selectMap(List<Course> courseList) {
		Map<Integer, List<PreCourse>> map = new HashMap<Integer, List<PreCourse>>();
		for (Course c : courseList) {
			List<PreCourse> list = preCourseDao.selectList(c.getCourseNo());
			map.put(c.getCourseNo(), list);
		}
		
		return map;
	}

	public int insertPreCourse(PreCourse preCourse, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		try {
			result = preCourseDao.insertPreCourse(session, preCourse);
			
			if (attach != null && result > 0) {
				attach.setTypeNo(Attach.PRE_COURSE);
				attach.setPkNo(preCourse.getPreNo());
				result = preCourseDao.insertAttach(session, attach);
			}

			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public PreCourse selectPreCourse(int preNo) {
		return preCourseDao.selectPreCourse(preNo);
	}

	public Attach selectAttach(int preNo) {
		Attach attach = preCourseDao.selectAttach(preNo);
		return attach;
	}

	public int updatePreCourse(PreCourse preCourse, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		try {
			result = preCourseDao.updatePreCourse(session, preCourse);
			if (attach != null && result > 0) {
				attach.setTypeNo(Attach.PRE_COURSE);
				attach.setPkNo(preCourse.getPreNo());
				if (result > 0) {
					result = -1;
					result = preCourseDao.deleteAttach(session, attach);
				}
				if (result > 0) {
					result = -1;
					result = preCourseDao.insertAttach(session, attach);
				}
			}

			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public int deleteOne(int preNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		try {
			result = preCourseDao.deleteOne(session, preNo);
			if (result > 0) {
				Attach attach = new Attach();
				attach.setPkNo(preNo);
				preCourseDao.deleteAttach(session, attach);
			}
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}
	

}
