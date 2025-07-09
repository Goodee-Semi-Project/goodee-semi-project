package com.goodee.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Question {
	private int questNo;
	private int accountNo;
	private String questTitle;
	private String questContetn;
	private String questReg;
	private String questMod;
	private String accountId;
	
	private String keyword;
	private String searchBy;
	private String orderBy;
}
