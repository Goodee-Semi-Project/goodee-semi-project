package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.mapper.PetMapper;

public class PetDao implements PetMapper {
	@Override
	public List<Pet> selectPetList(Pet param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Pet> list = session.selectList("com.goodee.semi.mapper.PetMapper.selectPetList", param);
		session.close();
		return list;
	}

	@Override
	public int selectPetCount(Pet param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.goodee.semi.mapper.PetMapper.selectPetCount", param);
		session.close();
		return count;
	}
	
	@Override
	public int updatePet(Pet param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.PetMapper.updatePet", param);
		session.close();
		return result;
	}
	
	@Override
	public List<Pet> selectAllPetByCourseNo(String selectAllPetByCourseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Pet> list = session.selectList("com.goodee.semi.mapper.PetMapper.selectAllPetByCourseNo", selectAllPetByCourseNo);
		session.close();
		return list;
	}
}
