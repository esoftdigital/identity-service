package com.identity.service.repository.impl;


import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.mapper.RolesRowMapper;
import com.identity.service.models.Roles;
import com.identity.service.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RoleDaoServiceImpl implements RoleRepository {

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Autowired
	Environment env;

	@Override
	public List<Roles> procAddRole(Roles roles) {

		String sql = env.getProperty("sp-func.role");
		List<Roles> roleList = new ArrayList<>();

		try {
			Object[] in = new Object[] { roles.getFlagId(), roles.getRoleId(), roles.getRoleName(), roles.getRoleCode(),
					roles.getRoleDescription(), roles.getIsDisabled(), roles.getRequestUserName() };

			roleList = jdbcTemplate.query(sql, new RolesRowMapper(), in);

		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}

		return roleList;
	}

}
