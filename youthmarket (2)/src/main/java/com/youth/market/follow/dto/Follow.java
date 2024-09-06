package com.youth.market.follow.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Follow {
	private int flId;
	private int fwId;
	private int sellCount;
	private int userNo;
}
