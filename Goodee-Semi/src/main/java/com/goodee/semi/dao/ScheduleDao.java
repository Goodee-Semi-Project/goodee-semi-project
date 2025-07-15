package com.goodee.semi.dao;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.mapper.ScheduleMapper;

public class ScheduleDao implements ScheduleMapper {
	
	@Override
	public List<Schedule> selectScheduleList(HashMap<String, LocalDateTime> map) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectScheduleList", map);
		session.close();
		return list;
	}

}
