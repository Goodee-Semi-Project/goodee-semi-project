package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.PreTestDao;
import com.goodee.semi.dto.PreTest;

public class PreTestService {
	PreTestDao dao = new PreTestDao();

	public List<PreTest> selectList(String preNo) {
		return dao.selectList(preNo);
	}

	public int updateList(List<PreTest> list) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		try {
			for (PreTest preTest : list) {
				result = -1;
				
				result = dao.countOne(session, preTest);
				
				if (result > 0) {
					result = dao.update(session, preTest);
				} else {
					result = dao.insertPreTest(session, preTest);
				}
				
			}
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public int delete(String testNo) {
		return dao.delete(testNo);
	}

}
