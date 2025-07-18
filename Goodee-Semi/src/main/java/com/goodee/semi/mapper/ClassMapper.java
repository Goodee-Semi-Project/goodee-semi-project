package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.PetClass;

public interface ClassMapper {
	PetClass selectClassByCourseNoAndPetNo(PetClass keyObj);
	int deleteClass(int classNo);
	List<PetClass> selectListByAccountNo(int accountNo);
}
