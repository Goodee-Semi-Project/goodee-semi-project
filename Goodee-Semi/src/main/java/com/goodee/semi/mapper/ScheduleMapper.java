package com.goodee.semi.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.Schedule;

public interface ScheduleMapper {

	List<Schedule> selectScheduleList(Map<String, LocalDate> map);

}
