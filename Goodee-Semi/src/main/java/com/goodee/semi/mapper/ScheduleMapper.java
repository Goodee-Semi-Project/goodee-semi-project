package com.goodee.semi.mapper;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import com.goodee.semi.dto.Schedule;

public interface ScheduleMapper {

	List<Schedule> selectScheduleList(HashMap<String, LocalDateTime> map);

}
