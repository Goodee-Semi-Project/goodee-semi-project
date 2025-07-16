package com.goodee.semi.service;

import com.goodee.semi.dao.ClassDao;

public class ClassService {
	ClassDao classDao = new ClassDao();
	
	public int deleteClass(int classNo) {
		return classDao.deleteClass(classNo);
	}
	
}
