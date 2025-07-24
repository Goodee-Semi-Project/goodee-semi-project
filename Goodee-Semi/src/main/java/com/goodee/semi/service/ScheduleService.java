package com.goodee.semi.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.Schedule;

public class ScheduleService {
	private ScheduleDao dao = new ScheduleDao();

	public List<Schedule> selectScheduleList(Map<String, String> map) {
		return dao.selectScheduleList(map);
	}

	public List<Schedule> selectCourseList(int accountNo) {
		return dao.selectCourseList(accountNo);
	}
	
	public List<Schedule> selectAccountList(int courseNo) {
		return dao.selectAccountList(courseNo);
	}

	public List<Schedule> selectPetList(Schedule sched) {
		return dao.selectPetList(sched);
	}

	public Integer selectClassNo(Schedule sched) {
		return dao.selectClassNo(sched);
	}
	
	public int selectSchedStep(Schedule sched) {
		return dao.selectSchedStep(sched);
	}

	public Schedule insert(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = dao.insert(sched);
		
		Schedule insertedSched = null;
		if(result != 0) {
			insertedSched = dao.selectSchedule(sched.getSchedNo());
		}
		
		return insertedSched;
	}

	public int update(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Integer ClassNo = dao.selectClassNo(sched);
		int result = 0;
		
		if(ClassNo != null) {
			System.out.println("[ScheduleService] ClassNo 조회 성공");
			sched.setClassNo(ClassNo);
			result = dao.update(sched);
		}
		
		return result;
	}
	
	public List<Schedule> selectScheduleListAttend(Schedule schedule) {
		return dao.selectScheduleListAttend(schedule);
	}

	public int delete(int schedNo) {
		return dao.delete(schedNo);
	}

	public int deleteScheduleBySchedNo(int schedNo) {
		return dao.deleteScheduleBySchedNo(schedNo);
	}
	
	public int updateScheduleAttend(Schedule sched) {
		return dao.updateScheduleAttend(sched);
	}
	
	public Schedule selectSchedule(int schedNo) {
		return dao.selectSchedule(schedNo);
	}
	
}
