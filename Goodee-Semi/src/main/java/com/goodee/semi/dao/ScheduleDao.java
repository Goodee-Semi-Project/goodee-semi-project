package com.goodee.semi.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.mapper.ScheduleMapper;

public class ScheduleDao implements ScheduleMapper {
	
	@Override
	public List<Schedule> selectScheduleList(Map<String, LocalDate> map) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectScheduleList", map);
		session.close();
		return list;
	}

}
