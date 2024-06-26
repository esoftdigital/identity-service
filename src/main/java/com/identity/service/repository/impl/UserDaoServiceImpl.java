package com.identity.service.repository.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.models.Users;
import com.identity.service.repository.UsersRepository;
import com.identity.service.util.JdbcQueryBuilder;

@Component
public class UserDaoServiceImpl implements UsersRepository {

	@Autowired
	JdbcQueryBuilder jdbcQueryBuilder;

	@Autowired
	Environment env;

	@Override
	@Transactional
	public List<Map<String, Object>> procAddUsers(Users user) {
		// TODO Auto-generated method stub
		String sql = env.getProperty("sp-func.user");
		List<Map<String, Object>> result = new ArrayList<>();
		ObjectMapper mapper = new ObjectMapper();
	    

		try {
			String userPhone = mapper.writeValueAsString(user.getUserPhone());
			String userEmail = mapper.writeValueAsString(user.getUserEmail());
			String userLocation = mapper.writeValueAsString(user.getUserLocation());
			String userRole = mapper.writeValueAsString(user.getUserRole());
			
			Object[] in = new Object[] { user.getFlagId(), user.getCountryId(), user.getClientId(),
					user.getLocationTypeId(), user.getGeographyTypeId(), user.getUserId(), user.getHonorificId(),
					user.getFirstName(), user.getMiddleName(), user.getLastName(), user.getGenderId(),
					user.getMaritalStatusId(), user.getDateOfBirth(), user.getBloodGroupId(), user.getHobbies(),
					user.getLoginName(), user.getPassword(), user.getPhoto(), userPhone, userEmail,
					userLocation, userRole, user.getIsDisabled(), user.getRequestUserName() };

			result = jdbcQueryBuilder.getJdbcQueryBuilder(result, in, sql, "User");

		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}

		return result;
	}

	@Override
	@Transactional
	public Map<String, Object> procConstants(Users user) {
		String sql = env.getProperty("sp-func.user");
		Map<String, Object> result = new HashMap<>();
		try {
			Object[] in = new Object[] { user.getFlagId(), user.getCountryId(), user.getClientId(),
					user.getLocationTypeId(), user.getGeographyTypeId(), user.getUserId(), user.getHonorificId(),
					user.getFirstName(), user.getMiddleName(), user.getLastName(), user.getGenderId(),
					user.getMaritalStatusId(), user.getDateOfBirth(), user.getBloodGroupId(), user.getHobbies(),
					user.getLoginName(), user.getPassword(), user.getPhoto(), user.getUserPhone(), user.getUserEmail(),
					user.getUserLocation(), user.getUserRole(), user.getIsDisabled(), user.getRequestUserName() };

			result = conversionLogic(jdbcQueryBuilder.getJdbcQueryBuilderWithMap(new HashMap<>(), in, sql, "User"));
		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}

		return result;
	}

	private Map<String, Object> conversionLogic(Map<String, String> result)
			throws JsonMappingException, JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		return result.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, e -> {
			try {
				return objectMapper.readValue(e.getValue(), Object.class);
			} catch (JsonProcessingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return e;
		}));
	}

	@SuppressWarnings("unused")
	private Map<String, Object> comonConversion(Map<String, String> result)
			throws JsonMappingException, JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		return result.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, e -> {
			return e.getValue();
		}));
	}
}
