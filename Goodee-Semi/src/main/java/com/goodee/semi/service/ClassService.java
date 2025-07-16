package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dto.PetClass;

public class ClassService {
	ClassDao classDao = new ClassDao();
	
	public int deleteClass(int classNo) {
		return classDao.deleteClass(classNo);
	}

	public List<PetClass> selectListByAccountNo(int accountNo) {
		List<PetClass> list = classDao.selectListByAccountNo(accountNo);
		return list;
	}
	
}
