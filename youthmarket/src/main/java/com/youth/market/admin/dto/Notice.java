package com.youth.market.admin.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@NoArgsConstructor 
@AllArgsConstructor
@Data
public class Notice {
    private int noticeNo;
    private String noticeTitle;
    private int noticeHit;
    private Date createDate;
    private String noticeContent;
    
}


