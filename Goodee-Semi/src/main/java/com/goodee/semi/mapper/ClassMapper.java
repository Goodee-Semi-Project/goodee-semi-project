package com.goodee.semi.mapper;

import com.goodee.semi.dto.PetClass;

public interface ClassMapper {
	PetClass selectClassByCourseNoAndPetNo(PetClass keyObj);
	int deleteClass(int classNo);
}
