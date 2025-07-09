package com.goodee.semi.dto;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Account {
	private int accountNo;
	private int author;
	private String accountId;
	private String accountPw;
	private char available;
	
	private String reg_date;
	private String name;
	private char gender;
	private String birth;
	private String phone;
	private String email;
	private int postNum;
	private String address;
	private String addressDetail;
}
