package com.identity.service.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
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
	private String hobbyIds;
	private short attemptCount;
	private Date expiryDate;
	
	@JsonProperty("userEmail")
	private List<UserEmail> userEmail;
	@JsonProperty("userRole")
	private List<UserRole> userRole;
	@JsonProperty("userPhone")
	private List<UserPhone> userPhone;
	@JsonProperty("userLocation")
	private List<UserLocation> userLocation;

	private Boolean isForcePasswordChange;
	private Boolean isTempBlocked;
	private Boolean isBlocked;
	private String blockedOn;
	private String profileSettingValue;
	private String passwordLastChangedOn;
	private String passwordExpiredOn;
	private String photos;
	private String bloodGroupName;
	private String maritalStatusName;
	private String genderName;
	private String displayName;
	private String honorificName;
}
