package com.goodee.semi.dto;

import java.time.LocalDateTime;

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
public class MyInfo {
	private int infoNo;
	private int userNo;
	private LocalDateTime regDate;
	private char userGender;
	private String birDate;
	private String phone;
	private String email;
	private String postNum;
	private String address;
	private String addressDetail;
	
	private String userName;
}
