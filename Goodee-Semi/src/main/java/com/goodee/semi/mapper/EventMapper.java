package com.goodee.semi.mapper;

import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.Event;

public interface EventMapper {

	List<Event> selectEventList(Map<String, String> map);
	List<Event> selectCourseList(int accountNo);
	List<Event> selectAccountList(int accountNo);
	List<Event> selectPetList(Map<String, Integer> map);
	int insert(Event event);
	Event selectEvent(int schedNo);
	int selectClassNo(Event event);
}
