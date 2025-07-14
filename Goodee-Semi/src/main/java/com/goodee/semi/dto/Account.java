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
	private String name;
	private char available;
	
}
