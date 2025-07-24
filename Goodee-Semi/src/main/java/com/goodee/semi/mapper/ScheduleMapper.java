package com.goodee.semi.mapper;

import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;

public interface ScheduleMapper {

	List<Schedule> selectScheduleList(Map<String, String> map);
	List<Schedule> selectCourseList(int accountNo);
	List<Schedule> selectAccountList(int courseNo);
	List<Schedule> selectPetList(Schedule sched);
	List<Schedule> selectScheduleListByClassNo(PetClass petClass);
	Integer selectClassNo(Schedule sched);
	int insert(Schedule sched);
	Schedule selectSchedule(int schedNo);
	int update(Schedule sched);
	int delete(int schedNo);
	int selectSchedStep(Schedule sched);
	List<Schedule> selectScheduleListAttend(Schedule schedule);
	int deleteScheduleBySchedNo(int schedNo);
	int updateScheduleAttend(Schedule sched);
	int selectCountAttend(Schedule sched);
}
