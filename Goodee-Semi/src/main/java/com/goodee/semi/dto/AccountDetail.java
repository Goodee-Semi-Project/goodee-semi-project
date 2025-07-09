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
public class AccountDetail extends Account {
	private String reg_date;
	private char gender;
	private String birth;
	private String phone;
	private String email;
	private int postNum;
	private String address;
	private String addressDetail;
}
