package com.identity.service.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
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

	@JsonIgnore
	private short flagId;
	private Boolean isDisabled;
	private short locationId;
	private String locationTypeName;
	private String locationName;
	private Boolean isPrimaryLogin;

}