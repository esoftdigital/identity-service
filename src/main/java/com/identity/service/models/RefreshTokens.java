package com.identity.service.models;

import lombok.Data;

import java.util.Date;

@Data
public class RefreshTokens {

    private long tokenId;
    private User user;
    private String token;
    private Date expiryDate;
    private Integer userId;
    private String responseCode;
    private String responseString;

}
