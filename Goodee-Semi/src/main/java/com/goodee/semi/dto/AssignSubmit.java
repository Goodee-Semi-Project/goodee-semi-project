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
public class AssignSubmit {
	private int submitNo;
	private int assignNo;
	private String submitTitle;
	private String submitContent;
	private String submitDate;
	
	private Attach submitAttach;
}
