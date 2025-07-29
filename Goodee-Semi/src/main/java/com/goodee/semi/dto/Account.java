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
	public static final int TRAINER_AUTHOR = 1;
	public static final int MEMBER_AUTHOR = 2;
	
	private int accountNo;
	private int author;
	private String accountId;
	private String accountPw;
	private String name;
	private char available;
	
	private Attach profileAttach;
}
