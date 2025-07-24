package com.goodee.semi.dto;

import com.goodee.semi.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Review extends Paging {
	private int reviewNo;
	private int classNo;
	private String reviewTitle;
	private String reviewContent;

	private String regDate;
	private String modDate;
	
	private int accountNo;
	private int authNo;
	private String accountId;
	private String courseTitle;
	private String keyword;
	private String category;
	private String order;
}
