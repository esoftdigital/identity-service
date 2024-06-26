package com.identity.service.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRole {
	
	private short roleId;
	private Integer locationTypeId;
	private Integer locationId;
	private boolean isPrimaryLogin;

}
