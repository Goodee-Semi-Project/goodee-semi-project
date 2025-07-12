package com.goodee.semi.dto;

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
public class Attachment {
	int attachNo;
	int typeNo;
	int pkNo;
	String oriName;
	String saveName;
}
