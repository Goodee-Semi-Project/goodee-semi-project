package com.goodee.semi.dto;

import com.goodee.semi.common.vo.Paging;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Notice extends Paging{
	private int noticeNo;
	private int accountNo;
	private String noticeTitle;
	private String noticeContent;
	private String regDate;
	private String modDate;
	private String nailUp;
	private String writer;
	private String keyword;
	
	private Attach noticeAttach;
}
