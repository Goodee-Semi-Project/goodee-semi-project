package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
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
	public int updatePet(SqlSession session, Pet param) {
		return session.update("com.goodee.semi.mapper.PetMapper.updatePet", param);
	}
	
	@Override
	public int updateAttach(SqlSession session, Attach param) {
		return session.update("com.goodee.semi.mapper.PetMapper.updateAttach", param);
	}
	
	@Override
	public int deletePet(SqlSession session, int petNo) {
		return session.delete("com.goodee.semi.mapper.PetMapper.deletePet", petNo);
	}
	
	@Override
	public int deleteAttach(SqlSession session, int petNo) {
		return session.update("com.goodee.semi.mapper.PetMapper.deleteAttach", petNo);
	}
	
	@Override
	public int insertPet(SqlSession session, Pet param) {
		return session.insert("com.goodee.semi.mapper.PetMapper.insertPet", param);
	}
	
	@Override
	public int insertAttach(SqlSession session, Attach param) {
		return session.update("com.goodee.semi.mapper.PetMapper.insertAttach", param);
	}

	@Override
	public Pet selectPetOne(int petNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Pet pet = session.selectOne("com.goodee.semi.mapper.PetMapper.selectPetOne", petNo);
		session.close();
		
		return pet;
	}
	
	@Override
	public List<Pet> selectAllPetByCourseNo(String selectAllPetByCourseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Pet> list = session.selectList("com.goodee.semi.mapper.PetMapper.selectAllPetByCourseNo", selectAllPetByCourseNo);
		session.close();
		return list;
	}

	public List<Pet> selectMyPetInCourse(Course key) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Pet> petList = session.selectList("com.goodee.semi.mapper.PetMapper.selectMyPetInCourse", key);
		session.close();

		return petList;
	}
}
