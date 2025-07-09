package com.goodee.semi.mapper;

import com.goodee.semi.dto.AccountDetail;

public interface AccountMapper {
	int insertAccount(AccountDetail account);
	int insertAccountInfo(AccountDetail account);
}
