package com.goodee.semi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Event;
import com.goodee.semi.mapper.EventMapper;

public class EventDao implements EventMapper {
	
	@Override
	public List<Event> selectEventList(Map<String, String> map) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Event> list = session.selectList("com.goodee.semi.mapper.EventMapper.selectEventList", map);
		session.close();
		return list;
	}
	
	@Override
	public List<Event> selectCourseList(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Event> list = session.selectList("com.goodee.semi.mapper.EventMapper.selectCourseList", accountNo);
		session.close();
		return list;
	}
	
	@Override
	public List<Event> selectAccountList(int courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Event> list = session.selectList("com.goodee.semi.mapper.EventMapper.selectAccountList", courseNo);
		session.close();
		return list;
	}
	
	@Override
	public List<Event> selectPetList(Map<String, Integer> map) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Event> list = session.selectList("com.goodee.semi.mapper.EventMapper.selectPetList", map);
		session.close();
		return list;
	}
	
	@Override
	public int insert(Event event) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.EventMapper.insert", event);
		session.close();
		return result;
	}
	
	@Override
	public int selectClassNo(Event event) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.goodee.semi.mapper.EventMapper.selectClassNo", event);
		session.close();
		return result;
	}
	
	@Override
	public Event selectEvent(int schedNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Event event = session.selectOne("com.goodee.semi.mapper.EventMapper.selectEvent", schedNo);
		session.close();
		return event;
	}
	
	@Override
	public int update(Event event) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.EventMapper.update", event);
		session.close();
		return result;
	}
  
}
