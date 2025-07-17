package com.goodee.semi.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
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
	
	public List<Event> selectAccountList(int courseNo) {
		return dao.selectAccountList(courseNo);
	}

	public List<Event> selectPetList(Map<String, Integer> map) {
		return dao.selectPetList(map);
	}

	public int selectClassNo(Event event) {
		return dao.selectClassNo(event);
	}
	
	public Event insert(Event event) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = dao.insert(event);
		
		Event insertedEvent = null;
		if(result != 0) {
			insertedEvent = dao.selectEvent(event.getSchedNo());
		}
		
		return insertedEvent;
	}

}
