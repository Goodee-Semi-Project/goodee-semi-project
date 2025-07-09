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
public class Member {
	private int memberNo;
	private int author;
	private String memberId;
	private String memberPw;
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
