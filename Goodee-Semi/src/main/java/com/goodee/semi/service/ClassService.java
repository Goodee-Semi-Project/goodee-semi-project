package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dao.EnrollDao;
import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;

public class ClassService {
	ClassDao classDao = new ClassDao();
	ScheduleDao scheduleDao = new ScheduleDao();
	CourseDao courseDao = new CourseDao();
	EnrollDao enrollDao = new EnrollDao();
	
	public int deleteClassAndUpdateEnroll(int classNo) {
		int result = 0;
		PetClass petClass = classDao.selectClass(classNo);
		result = enrollDao.updateEnrollByPetNo(petClass.getPetNo());
		if(result > 0) {
			result = classDao.deleteClass(classNo);
		}
		return result;
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
