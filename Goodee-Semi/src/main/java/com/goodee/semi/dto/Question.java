package com.goodee.semi.dto;

import com.goodee.semi.common.vo.Paging;

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
public class Question extends Paging{
	private int questNo;
	private int accountNo;
	private String questTitle;
	private String questContent;
	private String questReg;
	private String questMod;
	private String accountId;
	
	private String keyword;
	private String searchBy;
	private String orderBy;
}
