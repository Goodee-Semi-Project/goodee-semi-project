package com.goodee.semi.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.goodee.semi.dto.Event;

public interface EventMapper {

	List<Event> selectEventList(Map<String, String> map);

}
