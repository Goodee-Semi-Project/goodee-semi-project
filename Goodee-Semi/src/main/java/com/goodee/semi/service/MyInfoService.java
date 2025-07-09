package com.goodee.semi.service;

import com.goodee.semi.dao.MyInfoDAO;
import com.goodee.semi.dto.MyInfo;

public class MyInfoService {
	MyInfoDAO dao = new MyInfoDAO();

	public MyInfo selectMyInfo(int userNo) {
		MyInfo myInfo = dao.selectMyInfo(userNo);
		
		return myInfo;
	}
	
	public int updateMyInfo(MyInfo param) {
		int result = dao.updateMyInfo(param);
		
		return result;
	}

}
