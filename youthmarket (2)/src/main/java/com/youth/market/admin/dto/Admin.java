package com.youth.market.admin.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class Admin {
	private String AdminId;
	private String AdminPassword;
}
