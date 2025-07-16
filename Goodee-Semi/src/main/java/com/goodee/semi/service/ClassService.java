package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dao.ReviewDao;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;

public class ClassService {
	CourseDao courseDao = new CourseDao();
	PetDao petDao = new PetDao();
	ClassDao classDao = new ClassDao();
	ReviewDao reviewDao = new ReviewDao();
	
	public List<Pet> selectAllPetByCourseNo(String courseNo) {
		List<Pet> list = petDao.selectAllPetByCourseNo(courseNo);
		for (Pet p : list) {
			String oriName = p.getAccountName().substring(0, 1);
			String newName = oriName + "**";
			p.setAccountName(newName);
		}
		return list;
	}
	
	public Course selectCourseOne(String courseNo) {
		return courseDao.selectCourseOne(courseNo);
	}
	
	public int deleteClass(int classNo) {
		return classDao.deleteClass(classNo);
	}
	
}
