package com.goodee.semi.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dao.EventDao;
import com.goodee.semi.dto.Event;

public class EventService {
	private EventDao dao = new EventDao();

	public List<Event> selectEventList(Map<String, String> map) {
		return dao.selectEventList(map);
	}

}
