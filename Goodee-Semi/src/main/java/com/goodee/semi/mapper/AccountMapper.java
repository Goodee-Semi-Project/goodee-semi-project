package com.goodee.semi.mapper;

import com.goodee.semi.dto.AccountDetail;

public interface AccountMapper {
	AccountDetail selectAccountDetail(int userNo);
	int updateAccountDetail(AccountDetail param);

}
