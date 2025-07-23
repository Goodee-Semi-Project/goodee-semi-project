package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Assign;

public interface AssignMapper {
	Assign selectAssign(int assignNo);
	List<Assign> selectAssignListByClassNo(int classNo);
	int insertAssign(Assign assign);
	int updateAssign(Assign assign);
}
