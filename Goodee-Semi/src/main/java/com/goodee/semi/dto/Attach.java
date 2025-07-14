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
public class Attach {
	public static final int ACCOUNT = 1;
	public static final int PET = 2;
	public static final int COURSE = 3;
	public static final int PRE_COURSE = 4;
	public static final int ASSIGN = 5;
	public static final int SUBMIT = 6;
	public static final int REVIEW = 7;
	public static final int NOTICE = 8;
	
	private int attachNo;
	private int typeNo;
	private int pkNo;
	private String originName;
	private String savedName;
}
