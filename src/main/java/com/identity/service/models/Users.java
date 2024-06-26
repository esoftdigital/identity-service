package com.identity.service.models;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users implements Serializable {

	private static final long serialVersionUID = 1L;

	private String responseCode;
	private String responseString;

	private String requestDate;
	private String requestUserName;

	private String firstName;
	private String middleName;
	private String lastName;
	private String loginName;
	private String password;
	private String hobbies;
	private byte[] photo;

	@JsonIgnore
	private short flagId;
	private Boolean isDisabled;
	private Integer userId;

	private Date dateOfBirth;
	private short countryId;
	private String countryName;
	private String clientName;
	private short clientId;
	private short locationTypeId;
	private short geographyTypeId;
	private short honorificId;
	private short genderId;
	private short maritalStatusId;
	private short bloodGroupId;
	
	@JsonProperty("userEmail")
	private List<UserEmail> userEmail;
	@JsonProperty("userRole")
	private List<UserRole> userRole;
	@JsonProperty("userPhone")
	private List<UserPhone> userPhone;
	@JsonProperty("userLocation")
	private List<UserLocation> userLocation;

}
