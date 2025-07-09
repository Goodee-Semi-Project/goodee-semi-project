package com.goodee.semi.mapper;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;

public interface AccountMapper {
	int insertAccount(AccountDetail account);
	int insertAccountInfo(AccountDetail account);
	Account loginInfo(Account result);
	Account selectAccountByNameAndEmail(AccountDetail account);

}
