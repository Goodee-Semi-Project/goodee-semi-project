package com.goodee.semi.mapper;

import com.goodee.semi.dto.MyInfo;

public interface MyInfoMapper {
	MyInfo selectMyInfo(int userNo);
	int updateMyInfo(MyInfo param);
}
