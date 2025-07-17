package com.goodee.semi.dto;

import lombok.NoArgsConstructor;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Tag {
	private int tagNo;
	private String tagText;
	private int courseNo;
	
	private List<String> keyTag;
	private int totalTags;
}
