package com.goodee.semi.mapper;

import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.Schedule;

public interface ScheduleMapper {

	List<Schedule> selectScheduleList(Map<String, String> map);
	List<Schedule> selectCourseList(int accountNo);
	List<Schedule> selectAccountList(int courseNo);
	List<Schedule> selectPetList(Map<String, Integer> map);
	int selectClassNo(Schedule sched);
	int insert(Schedule sched);
	Schedule selectSchedule(int schedNo);
	int update(Schedule sched);
	int delete(int schedNo);
}
