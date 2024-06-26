package com.identity.service.repository.impl;

import java.util.ArrayList;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.models.PasswordChange;
import com.identity.service.repository.PasswordChangeRepository;
import com.identity.service.util.JdbcQueryBuilder;

@Component
public class PasswordChangeDaoServiceImp implements PasswordChangeRepository {

	@Autowired
	JdbcQueryBuilder jdbcQueryBuilder;

	@Autowired
	Environment env;
	
	@Override
	@Transactional
	public List<PasswordChange> procAddPasswordChange(PasswordChange paaswordChange) {
		// TODO Auto-generated method stub
		String sql = env.getProperty("sp-func.passwordChangeDetail");
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			Object[] in = new Object[] { paaswordChange.getFlagId(), paaswordChange.getClientId(), paaswordChange.getUserId(),
					paaswordChange.getOldPassword(),paaswordChange.getNewPassword(), paaswordChange.isDisabled(), paaswordChange.getRequestUserName() };

			result = jdbcQueryBuilder.getJdbcQueryBuilder(result, in, sql, "PasswordChangeDetail");
		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}
		return convertListOfMapToList(result);
	}
	
	private List<PasswordChange> convertListOfMapToList(List<Map<String, Object>> result) {

		return result.stream().map(m -> {
			PasswordChange pass = new PasswordChange();
			String respCode = String.valueOf(m.get("responseCode"));
			String respString = String.valueOf(m.get("responseString"));
			pass.setResponseCode(respCode == "null" ? null : respCode);
			pass.setResponseString(respString == "null" ? null : respString);
			return pass;
		}).collect(Collectors.toList());
	}

}
