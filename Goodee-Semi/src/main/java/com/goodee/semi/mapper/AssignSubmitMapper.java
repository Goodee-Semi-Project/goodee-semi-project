package com.goodee.semi.mapper;

import com.goodee.semi.dto.AssignSubmit;

public interface AssignSubmitMapper {
	AssignSubmit selectAssignSubmitByAssignNo(int assignNo);
	int insertAssignSubmit(AssignSubmit assignSubmit);
	int updateAssignSubmit(AssignSubmit assignSubmit);
}
