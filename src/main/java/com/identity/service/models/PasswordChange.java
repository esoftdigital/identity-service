package com.identity.service.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ser.std.SerializableSerializer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class PasswordChange extends SerializableSerializer{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String responseCode;
	private String responseString;
	@JsonIgnore
	private short flagId;
	private short clientId;
	private Integer userId;
	private String oldPassword;
	private String newPassword;
	private boolean isDisabled;
	private String requestUserName;

}
