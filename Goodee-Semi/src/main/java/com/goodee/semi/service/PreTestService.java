package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.PreTestDao;
import com.goodee.semi.dto.PreTest;

public class PreTestService {
	PreTestDao dao = new PreTestDao();

	public List<PreTest> selectList(String preNo) {
		return dao.selectList(preNo);
	}

}
