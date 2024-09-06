package com.youth.market.admin.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@NoArgsConstructor 
@AllArgsConstructor
@Data

public class Qa {
    private int qaNo;
    private String qaName;
    private String qaTitle;
    private String qaContent;
    private String qaImg;
    private int qaHit;
    private Date createDate;
    
    private MultipartFile upfile;
}