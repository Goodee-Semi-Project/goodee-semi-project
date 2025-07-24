package com.goodee.semi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;
import com.goodee.semi.mapper.ScheduleMapper;

public class ScheduleDao implements ScheduleMapper {

	@Override
	public List<Schedule> selectScheduleList(Map<String, String> map) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectScheduleList", map);
		session.close();
		return list;
	}

	@Override
	public List<Schedule> selectCourseList(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectCourseList", accountNo);
		session.close();
		return list;
	}

	@Override
	public List<Schedule> selectAccountList(int courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectAccountList", courseNo);
		session.close();
		return list;
	}

	@Override
	public List<Schedule> selectPetList(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectPetList", sched);
		session.close();
		return list;
	}

	@Override
	public Integer selectClassNo(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Integer result = session.selectOne("com.goodee.semi.mapper.ScheduleMapper.selectClassNo", sched);
		session.close();
		return result;
	}

	@Override
	public int insert(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.ScheduleMapper.insert", sched);
		session.close();
		return result;
	}

	@Override
	public Schedule selectSchedule(int schedNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Schedule sched = session.selectOne("com.goodee.semi.mapper.ScheduleMapper.selectSchedule", schedNo);
		session.close();
		return sched;
	}


	@Override
	public int update(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.ScheduleMapper.update", sched);
		session.close();
		return result;
	}
	
	@Override
	public int delete(int schedNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.ScheduleMapper.delete", schedNo);
		session.close();
		return result;
	}

	public List<Schedule> selectScheduleListAttend(Schedule schedule) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> list = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectScheduleListAttend", schedule);
		session.close();
		return list;
	}
	
	@Override
	public int deleteScheduleBySchedNo(int schedNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.ScheduleMapper.deleteScheduleBySchedNo", schedNo);
		session.close();
		return result;
	}
	
	@Override
	public int updateScheduleAttend(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.ScheduleMapper.updateScheduleAttend", sched);
		session.close();
		return result;
	}
	
	@Override
	public Integer selectSchedStep(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Integer result = session.selectOne("com.goodee.semi.mapper.ScheduleMapper.selectSchedStep", sched);
		session.close();
		return result;
	}

	public List<Schedule> selectScheduleListByClassNo(PetClass petClass) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Schedule> result = session.selectList("com.goodee.semi.mapper.ScheduleMapper.selectScheduleListByClassNo", petClass);
		session.close();
		
		return result;
	}
	
	public int selectCountAttend(Schedule sched) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.goodee.semi.mapper.ScheduleMapper.selectCountAttend", sched);
		session.close();
		
		return count;
	}

}
