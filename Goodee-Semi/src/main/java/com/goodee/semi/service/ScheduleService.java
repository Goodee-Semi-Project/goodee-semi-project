package com.goodee.semi.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.Schedule;

public class ScheduleService {
	private ScheduleDao dao = new ScheduleDao();

	public List<Schedule> selectScheduleList(Map<String, LocalDate> map) {
		return dao.selectScheduleList(map);
	}

}
