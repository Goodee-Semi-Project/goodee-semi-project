package com.goodee.semi.dto;

import com.goodee.semi.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Pet extends Paging {
	private int petNo;
	private int accountNo;
	private String petName;
	private char petGender;
	private int petAge;
	private String petBreed;
	
	
	
	
	
	private int attachNo;
	private String accountName;
	private int classNo;
}
