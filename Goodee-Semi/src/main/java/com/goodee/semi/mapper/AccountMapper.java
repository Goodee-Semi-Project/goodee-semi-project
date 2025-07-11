package com.goodee.semi.mapper;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;

public interface AccountMapper {
	int insertAccount(AccountDetail account);
	int insertAccountInfo(AccountDetail account);
	AccountDetail loginInfo(Account result);
	Account selectAccountByNameAndEmail(AccountDetail account);
	Account selectAccountByIdNameEmail(AccountDetail account);
	int updateNewPassword(AccountDetail account);
}
