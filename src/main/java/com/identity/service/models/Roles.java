package com.identity.service.models;

import lombok.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Roles implements Serializable {

	private static final long serialVersionUID = 1L;

	private String responseCode;
	private String responseString;
	private short roleId;
	private String roleName;
	private String roleCode;
	private String roleDescription;

	private String requestDate;
	private String requestUserName;
	private String status;

	private short flagId;
	private Boolean isDisabled;

}