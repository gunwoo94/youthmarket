package com.youth.market.review.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Review {
	private int REV_NO;
	private String REV_CONTENT;
	private int REV_SCORE;
	private Date CREATE_DATE;
	private String STATUS;
	private int SELL_NO;
	private int USER_NO;
}
