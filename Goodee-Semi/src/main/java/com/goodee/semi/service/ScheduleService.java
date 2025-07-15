package com.goodee.semi.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.Schedule;

public class ScheduleService {
	private ScheduleDao dao = new ScheduleDao();

	public List<Schedule> selectScheduleList(HashMap<String, LocalDateTime> map) {
		return dao.selectScheduleList(map);
	}

}
