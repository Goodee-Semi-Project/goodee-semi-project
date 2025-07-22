package com.goodee.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.goodee.semi.dao.PreProgressDao;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.dto.PreProgress;

public class PreProgressService {
	PreProgressDao dao = new PreProgressDao();

	public int insertOneWithAccountNo(PreProgress preProgress) {
		int result = -1;
		
		result = dao.countOne(preProgress);
		
		if (result > 0) {
			result = -1;
			result = dao.update(preProgress);
		} else {
			result = -1;
			result = dao.insertOneWithAccountNo(preProgress);
		}
		
		return result;
	}

	public PreProgress selectOne(PreProgress param) {
		return dao.selectOne(param);
	}

	public Map<Integer, PreProgress> selectMap(List<Course> courseList, Map<Integer, List<PreCourse>> preCourseMap) {
		Map<Integer, PreProgress> map = new HashMap<Integer, PreProgress>();
		for (Course c : courseList) {
			int classNo = c.getClassNo();
			for (PreCourse p : preCourseMap.get(c.getCourseNo())) {
				int preNo = p.getPreNo();
				PreProgress param = new PreProgress();
				param.setClassNo(String.valueOf(classNo));
				param.setPreNo(String.valueOf(preNo));
				
				int hash = Objects.hash(classNo, preNo);
				PreProgress preProg = dao.selectProg(param);
				map.put(hash, preProg);
			}
		}
		return map;
	}

}
