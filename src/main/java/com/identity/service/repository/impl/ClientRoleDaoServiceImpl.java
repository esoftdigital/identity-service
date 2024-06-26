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
import com.identity.service.models.ClientRoles;
import com.identity.service.repository.ClientRoleRepository;
import com.identity.service.util.JdbcQueryBuilder;

@Component
public class ClientRoleDaoServiceImpl implements ClientRoleRepository {
	@Autowired
	JdbcQueryBuilder jdbcQueryBuilder;

	@Autowired
	Environment env;

	@Override
	@Transactional
	public List<ClientRoles> procAddCleintRole(ClientRoles clientRoles) {
		String sql = env.getProperty("sp-func.clientRoleAllocation");
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			Object[] in = new Object[] { clientRoles.getFlagId(), clientRoles.getCountryId(), clientRoles.getClientId(),
					clientRoles.getRoleId(), false, clientRoles.getRequestUserName() };

			result = jdbcQueryBuilder.getJdbcQueryBuilder(result, in, sql, "ClientRoleAllocation");
		} catch (Exception e) {
			throw new RoleNotFoundException(e.getMessage());
		}
		return convertListOfMapToList(result);
	}

	private List<ClientRoles> convertListOfMapToList(List<Map<String, Object>> result) {

		return result.stream().map(m -> {
			ClientRoles role = new ClientRoles();
			String cId = String.valueOf(m.get("clientId") != null ? m.get("clientId") : "0");
			String crId = String.valueOf(m.get("clientRoleId") != null ? m.get("clientRoleId") : "0");
			String countryIds = String.valueOf(m.get("countryId") != null ? m.get("countryId") : "0");
			String userNm = String.valueOf(m.get("requestUserName"));
			String respCode = String.valueOf(m.get("responseCode"));
			String respString = String.valueOf(m.get("responseString"));
			String cName = String.valueOf(m.get("clientName"));
			String rName = String.valueOf(m.get("roleName"));
			String countryNames = String.valueOf(m.get("countryName"));
			String rId = String.valueOf(m.get("roleId"));
			role.setRoleId(rId == "null" ? null : rId);
			role.setClientId(Short.parseShort(cId));
			role.setCountryId(Short.parseShort(countryIds));
			role.setClientRoleId(Short.parseShort(crId));
			role.setRequestUserName(userNm == "null" ? null : userNm);
			role.setClientName(cName == "null" ? null : cName);
			role.setRoleName(rName == "null" ? null : rName);
			role.setCountryName(countryNames == "null" ? null : countryNames);
			role.setResponseCode(respCode == "null" ? null : respCode);
			role.setResponseString(respString == "null" ? null : respString);
			return role;
		}).collect(Collectors.toList());
	}

}
