package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;

public interface ClassMapper {
	PetClass selectClassByCourseNoAndPetNo(PetClass keyObj);
	PetClass selectClass(String classNo);
	int deleteClass(int classNo);
	List<PetClass> selectListByAccountNo(int accountNo);
	List<PetClass> selectClassListByAccountDetail(AccountDetail account);
	int updateClassProg(Schedule schedule);
}
