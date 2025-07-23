package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;

public class ClassService {
	ClassDao classDao = new ClassDao();
	ScheduleDao scheduleDao = new ScheduleDao();
	CourseDao courseDao = new CourseDao();
	
	public int deleteClass(int classNo) {
		return classDao.deleteClass(classNo);
	}

	public List<PetClass> selectListByAccountNo(int accountNo) {
		List<PetClass> list = classDao.selectListByAccountNo(accountNo);
		return list;
	}
	
	public PetClass selectClassByCourseNoAndPetNo(int courseNo, int petNo) {
		PetClass keyObj = new PetClass();
		keyObj.setCourseNo(courseNo);
		keyObj.setPetNo(petNo);
		
		return classDao.selectClassByCourseNoAndPetNo(keyObj);
	}
	
	public int updateClassProgBySchedule(Schedule schedule) {
		
		int currentStep = scheduleDao.selectCountAttend(schedule);
		int totalStep = courseDao.selectCourseOne(String.valueOf(schedule.getCourseNo())).getTotalStep();
		int currentProg = (int)((double)currentStep / totalStep * 100);
		schedule.setClassProg(currentProg);
		int result = classDao.updateClassProg(schedule);
		
		return result;
	}
}
