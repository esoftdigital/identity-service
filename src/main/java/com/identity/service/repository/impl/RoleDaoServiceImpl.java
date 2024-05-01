package com.identity.service.repository.impl;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.models.Roles;
import com.identity.service.repository.RoleRepository;
import com.identity.service.util.JdbcQueryBuilder;
import jakarta.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class RoleDaoServiceImpl implements RoleRepository {

	@Autowired
	JdbcQueryBuilder jdbcQueryBuilder;

	@Autowired
	Environment env;

	@Override
	@Transactional
	public List<Roles>  procAddRole(Roles roles) {
		String sql = env.getProperty("sp-func.role");
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			Object[] in = new Object[] { roles.getFlagId(), roles.getRoleId(), roles.getRoleName(), roles.getRoleCode(),
					roles.getRoleDescription(), roles.getIsDisabled(), roles.getRequestUserName() };

			result = jdbcQueryBuilder.getJdbcQueryBuilder(result,in,sql,"addrole");
		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}

		return convertListOfMapToList(result);
	}

	private List<Roles> convertListOfMapToList(List<Map<String, Object>> result)
	{
		return result.stream().map(m -> {
			Roles role = new Roles();
			String rId = String.valueOf(m.get("roleId"));
			role.setRoleId(Short.parseShort((rId == null) ? rId :  "0"));
			role.setRoleCode(String.valueOf(m.get("roleCode")));
			role.setRoleName(String.valueOf(m.get("roleName")));
			role.setRequestDate(String.valueOf(m.get("requestDate")));
			role.setRequestUserName(String.valueOf(m.get("requestUserName")));
			role.setIsDisabled(Boolean.parseBoolean(String.valueOf(m.get("isDisabled"))));
			role.setRoleDescription(String.valueOf(m.get("roleDescription")));
			role.setResponseCode(String.valueOf(m.get("responseCode")));
			role.setResponseString(String.valueOf(m.get("responseString")));
			return role;
		}).collect(Collectors.toList());
	}

}
