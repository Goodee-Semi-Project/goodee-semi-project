package com.goodee.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dao.PreCourseDao;
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
	

}
