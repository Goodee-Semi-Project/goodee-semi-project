package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;

public interface AccountMapper {
	int insertAccount(AccountDetail account);
	int insertAccountInfo(AccountDetail account);
	AccountDetail loginInfo(Account result);
	Account selectAccountByNameAndEmail(AccountDetail account);
	AccountDetail selectAccountDetail(String accountId);
	int updateAccountDetail(AccountDetail param);
	int checkIdPw(Account account);
	int deactivateAccount(Account account);
	int updateAccountPw(Account account);
	Account selectAccountByIdNameEmail(AccountDetail account);
	int updateNewPassword(AccountDetail account);
	AccountDetail selectAccountById(String param);
	Attach selectAttachByAccountNo(int accountNo);
	int deleteAttach(SqlSession session, Attach attach);
	int insertAttach(SqlSession session, Attach attach);
	Account selectAccountByPetNo(int petNo);
	List<Account> selectAccountTrainer4();
	int countTotalAccountNo();
}
