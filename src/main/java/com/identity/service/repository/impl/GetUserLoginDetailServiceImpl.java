package com.identity.service.repository.impl;

import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.models.*;
import com.identity.service.repository.GetUserLoginDetailRepository;
import com.identity.service.util.JdbcQueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class GetUserLoginDetailServiceImpl implements GetUserLoginDetailRepository {
    @Autowired
    JdbcQueryBuilder jdbcQueryBuilder;

    @Autowired
    Environment env;

    @Override
    @Transactional
    public List<Users> procAddUser(Users users) {
        return convertListOfMapToListUserDetails(getUserDetailsDataFromDB(users));
    }

    @Override
    @Transactional
    public List<Roles> procAddUserRoles(Users users) {
        return convertListOfMapToListUsersRoles(getUserDetailsDataFromDB(users));
    }

    @Override
    @Transactional
    public List<User> procAddUserByUserName(Users users) {
        return convertListOfMapByUserName(getUserDetailsDataFromDB(users));
    }

    @Override
    @Transactional
    public List<RefreshTokens> getRefreshToken(Users user) {
        return convertListOfMapByRefreshToken(getUserDetailsDataFromDB(user));
    }

    private List<RefreshTokens> convertListOfMapByRefreshToken(List<Map<String, Object>> result) {
        return result.stream().map(m -> {
            RefreshTokens refreshTokens = new RefreshTokens();
            User user = new User();
            String userId = String.valueOf(m.get("userId") != null ? m.get("userId") : "0");
            byte[] photo = String.valueOf(m.get("photo")).getBytes();
            String password = String.valueOf(m.get("password"));
            String userName = String.valueOf(m.get("userName"));
            String fullName = String.valueOf(m.get("fullName"));
            String lastName = String.valueOf(m.get("lastName"));
            String firstName = String.valueOf(m.get("firstName"));
            String genderName = String.valueOf(m.get("genderName"));
            String clientName = String.valueOf(m.get("clientName"));
            String countryName = String.valueOf(m.get("countryName"));
            String countryId = String.valueOf(m.get("countryId") != null ? m.get("countryId") : "0");
            String clientId = String.valueOf(m.get("clientId") != null ? m.get("clientId") : "0");
            String rId = String.valueOf(m.get("roleId") != null ? m.get("roleId") : "0");
            String roleName = String.valueOf(m.get("roleName"));
            String roleDesc = String.valueOf(m.get("roleDesc"));
            String roleCode = String.valueOf(m.get("roleCode"));
            String phone = String.valueOf(m.get("phone"));
            String email = String.valueOf(m.get("email"));
            String token = String.valueOf(m.get("token"));
            String expirationDate = String.valueOf(m.get("expirationDate"));
            refreshTokens.setResponseCode(String.valueOf(m.get("responseCode")));
            refreshTokens.setResponseString(String.valueOf(m.get("responseString")));
            user.setId(Long.parseLong(userId));
            user.setClientId(Short.parseShort(clientId));
            user.setCountryId(Short.parseShort(countryId));
            user.setCountryName(countryName);
            user.setClientName(clientName);
            user.setImage(photo);
            user.setLast_name(lastName);
            user.setFirst_name(firstName);
            user.setPhone(phone);
            user.setFullName(fullName);
            user.setGenderId(genderName);
            user.setEmail(email);
            user.setUsername(userName);
            user.setPassword(password);
            Set<Role> roles = new HashSet<>();
            Role r = new Role();
            r.setId(Integer.parseInt(rId));
            r.setRolecode(roleCode);
            r.setRoleName(roleName);
            r.setRoleDesc(roleDesc);
            roles.add(r);
            user.setRoles(roles);
            refreshTokens.setToken(token);
            SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                if(expirationDate != "null"){
                    refreshTokens.setExpiryDate(dtf.parse(expirationDate));
                }
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            refreshTokens.setUser(user);
            return refreshTokens;
        }).collect(Collectors.toList());
    }

    private List<Map<String, Object>> getUserDetailsDataFromDB(Users users) {
        String sql = env.getProperty("sp-func.getUserLoginDetails");
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            Object[] in = new Object[]{users.getFlagId(), users.getCountryId(), users.getClientId(), users.getUserId(),
                    users.getLoginName(), users.getPassword(),users.getExpiryDate(), users.getRequestUserName()};

            result = jdbcQueryBuilder.getJdbcQueryBuilder(result, in, sql, "GetUserLoginDetail");
        } catch (Exception e) {
            throw new RoleNotFoundException(e.getMessage());
        }
        return result;
    }

    private List<Roles> convertListOfMapToListUsersRoles(List<Map<String, Object>> result) {
        return result.stream().map(m -> {
            Roles role = new Roles();
            String rId = String.valueOf(m.get("roleId") != null ? m.get("roleId") : "0");
            String locationId = String.valueOf(m.get("locationId")!= null ? m.get("locationId") : "0");
            role.setRoleId(Short.parseShort(rId));
            role.setRoleCode(String.valueOf(m.get("roleCode")));
            role.setRoleName(String.valueOf(m.get("roleName")));
            role.setRequestDate(String.valueOf(m.get("requestDate")));
            role.setLocationId(Short.parseShort(locationId));
            role.setLocationTypeName(String.valueOf(m.get("locationTypeName")));
            role.setLocationName(String.valueOf(m.get("locationName")));
            role.setIsPrimaryLogin(Boolean.parseBoolean(String.valueOf(m.get("isPrimaryLogin"))));
            role.setRequestUserName(String.valueOf(m.get("requestUserName")));
            role.setIsDisabled(Boolean.parseBoolean(String.valueOf(m.get("isDisabled"))));
            role.setRoleDescription(String.valueOf(m.get("roleDescription")));
            role.setResponseCode(String.valueOf(m.get("responseCode")));
            role.setResponseString(String.valueOf(m.get("responseString")));
            return role;
        }).collect(Collectors.toList());
    }

    private List<Users> convertListOfMapToListUserDetails(List<Map<String, Object>> result) {
        return result.stream().map(m -> {
            Users user = new Users();
            String respCode = String.valueOf(m.get("responseCode"));
            String respString = String.valueOf(m.get("responseString"));
            user.setResponseCode(respCode == "null" ? null : respCode);
            user.setResponseString(respString == "null" ? null : respString);
            String userId = String.valueOf(m.get("userId") != null ? m.get("userId") : "0");
            String hobbyIds = String.valueOf(m.get("hobbyIds") != null ? m.get("hobbyIds") : "0");
            String countryId = String.valueOf(m.get("countryId") != null ? m.get("countryId") : "0");
            String clientId = String.valueOf(m.get("clientId") != null ? m.get("clientId") : "0");
            String attemptCount = String.valueOf(m.get("attemptCount") != null ? m.get("attemptCount") : "0");
            String isForcePasswordChange = String.valueOf(m.get("isForcePasswordChange"));
            String isTempBlocked = String.valueOf(m.get("isTempBlocked"));
            String isBlocked = String.valueOf(m.get("isBlocked"));
            String blockedOn = String.valueOf(m.get("blockedOn"));
            String profileSettingValue = String.valueOf(m.get("profileSettingValue"));
            String photo = String.valueOf(m.get("photo"));
            String passwordLastChangedOn = String.valueOf(m.get("passwordLastChangedOn"));
            String passwordExpiredOn = String.valueOf(m.get("passwordExpiredOn"));
            String password = String.valueOf(m.get("password"));
            String loginName = String.valueOf(m.get("loginName"));
            String clientName = String.valueOf(m.get("clientName"));
            String countryName = String.valueOf(m.get("countryName"));
            String bloodGroupName = String.valueOf(m.get("bloodGroupName"));
            String maritalStatusName = String.valueOf(m.get("maritalStatusName"));
            String genderName = String.valueOf(m.get("genderName"));
            String dateOfBirth = String.valueOf(m.get("dateOfBirth"));
            String displayName = String.valueOf(m.get("displayName"));
            String lastName = String.valueOf(m.get("lastName"));
            String middleName = String.valueOf(m.get("middleName"));
            String firstName = String.valueOf(m.get("firstName"));
            String honorificName = String.valueOf(m.get("honorificName"));
            user.setLastName(lastName);
            user.setMiddleName(middleName);
            user.setFirstName(firstName);
            user.setHonorificName(honorificName);
            user.setDisplayName(displayName);
            user.setGenderName(genderName);
            user.setMaritalStatusName(maritalStatusName);
            user.setDateOfBirth(dateOfBirth == "null" ? null : Date.valueOf(dateOfBirth));
            user.setBloodGroupName(bloodGroupName);
            user.setClientName(clientName);
            user.setCountryName(countryName);
            user.setUserId(Integer.parseInt(userId));
            user.setHobbyIds(hobbyIds);
            user.setCountryId(Short.parseShort(countryId));
            user.setClientId(Short.parseShort(clientId));
            user.setAttemptCount(Short.parseShort(attemptCount));
            user.setIsForcePasswordChange(Boolean.parseBoolean(isForcePasswordChange));
            user.setIsBlocked(Boolean.parseBoolean(isBlocked));
            user.setIsTempBlocked(Boolean.parseBoolean(isTempBlocked));
            user.setBlockedOn(blockedOn);
            user.setProfileSettingValue(profileSettingValue);
            user.setPasswordExpiredOn(passwordLastChangedOn);
            user.setPasswordLastChangedOn(passwordLastChangedOn);
            user.setPhotos(photo);
            user.setPasswordExpiredOn(passwordExpiredOn);
            user.setPassword(password);
            user.setLoginName(loginName);
            return user;
        }).collect(Collectors.toList());
    }

    private List<User> convertListOfMapByUserName(List<Map<String, Object>> result) {
        return result.stream().map(m -> {
          User user = new User();
            String userId = String.valueOf(m.get("userId") != null ? m.get("userId") : "0");
            byte[] photo = String.valueOf(m.get("photo")).getBytes();
            String password = String.valueOf(m.get("password"));
            String userName = String.valueOf(m.get("userName"));
            String fullName = String.valueOf(m.get("fullName"));
            String lastName = String.valueOf(m.get("lastName"));
            String firstName = String.valueOf(m.get("firstName"));
            String genderName = String.valueOf(m.get("genderName"));
            String clientName = String.valueOf(m.get("clientName"));
            String countryName = String.valueOf(m.get("countryName"));
            String countryId = String.valueOf(m.get("countryId") != null ? m.get("countryId") : "0");
            String clientId = String.valueOf(m.get("clientId") != null ? m.get("clientId") : "0");
            String rId = String.valueOf(m.get("roleId") != null ? m.get("roleId") : "0");
            String roleName = String.valueOf(m.get("roleName"));
            String roleDesc = String.valueOf(m.get("roleDesc"));
            String roleCode = String.valueOf(m.get("roleCode"));
            String phone = String.valueOf(m.get("phone"));
            String email = String.valueOf(m.get("email"));
            user.setClientName(clientName);
            user.setCountryName(countryName);
            user.setClientId(Short.parseShort(clientId));
            user.setCountryId(Short.parseShort(countryId));
            user.setId(Long.parseLong(userId));
            user.setImage(photo);
            user.setLast_name(lastName);
            user.setFirst_name(firstName);
            user.setPhone(phone);
            user.setFullName(fullName);
            user.setGenderId(genderName);
            user.setEmail(email);
            user.setUsername(userName);
            user.setPassword(password);
            Set<Role> roles = new HashSet<>();
            Role r = new Role();
            r.setId(Integer.parseInt(rId));
            r.setRolecode(roleCode);
            r.setRoleName(roleName);
            r.setRoleDesc(roleDesc);
            roles.add(r);
            user.setRoles(roles);
          return user;
        }).collect(Collectors.toList());
    }
}
