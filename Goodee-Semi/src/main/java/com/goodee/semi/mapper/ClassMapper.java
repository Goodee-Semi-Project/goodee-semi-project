package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.PetClass;

public interface ClassMapper {
	int deleteClass(int classNo);
	List<PetClass> selectListByAccountNo(int accountNo);
}
