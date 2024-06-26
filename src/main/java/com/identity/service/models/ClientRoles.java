package com.identity.service.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class ClientRoles {

	private String responseCode;
	private String responseString;
	private String clientName;
	private String roleName;
	private String countryName;
	private short clientRoleId;

	private String roleId;
	private short clientId;
	private short countryId;
	private String requestUserName;
	@JsonIgnore
	private short flagId;
}
