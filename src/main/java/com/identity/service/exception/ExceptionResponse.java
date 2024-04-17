package com.identity.service.exception;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ExceptionResponse {

    private Date timeStamp = new Date();
    private String message;
    private String details;
}
