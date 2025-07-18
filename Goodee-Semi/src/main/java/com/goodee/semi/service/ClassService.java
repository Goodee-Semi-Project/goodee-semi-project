package com.goodee.semi.service;

import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dto.PetClass;

public class ClassService {
	ClassDao classDao = new ClassDao();
	
	public int deleteClass(int classNo) {
		return classDao.deleteClass(classNo);
	}
	
	public PetClass selectClassByCourseNoAndPetNo(int courseNo, int petNo) {
		PetClass keyObj = new PetClass();
		keyObj.setCourseNo(courseNo);
		keyObj.setPetNo(petNo);
		
		return classDao.selectClassByCourseNoAndPetNo(keyObj);
	}
}
