package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Assign;

public interface AssignMapper {
	List<Assign> selectAssignListByClassNo(int classNo);
	int insertAssign(Assign assign);
}
