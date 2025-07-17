package com.goodee.semi.service;

import java.util.List;
import java.util.Map;

import com.goodee.semi.dao.EventDao;
import com.goodee.semi.dto.Event;

public class EventService {
	private EventDao dao = new EventDao();

	public List<Event> selectEventList(Map<String, String> map) {
		return dao.selectEventList(map);
	}

	public List<Event> selectCourseList(int accountNo) {
		return dao.selectCourseList(accountNo);
	}
	
	// TODO 마저 구현
	public Object selectAccountList(String value) {
		// TODO Auto-generated method stub
		return null;
	}

}
