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
public class Attach {
	public static final int ACCOUNT = 1;
	public static final int PET = 2;
	public static final int COURSE = 3;
	
	private int attachNo;
	private int typeNo;
	private int pkNo;
	private String originName;
	private String savedName;
}
