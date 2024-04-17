package com.identity.service.service;


import com.identity.service.EsUtil;
import com.identity.service.models.Roles;
import com.identity.service.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {

	@Autowired
	RoleRepository roleDaoService;

	public List<Roles> findAll() {
		Roles roles = new Roles();
		roles.setFlagId(EsUtil.ROLE_FIND_ALL_FLAG);
		return roleDaoService.procAddRole(roles);
	}

	public Roles findOne(short id) {

		Roles roles = new Roles();
		roles.setFlagId(EsUtil.ROLE_FIND_ONE_FLAG);
		roles.setRoleId(id);
		List<Roles> roleList = roleDaoService.procAddRole(roles);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;
	}

	public Roles save(Roles role) {
		role.setFlagId(EsUtil.ROLE_SAVE_FLAG);

		List<Roles> roleList = roleDaoService.procAddRole(role);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;

	}

	public Roles update(Roles role) {
		role.setFlagId(EsUtil.ROLE_UPDATE_FLAG);

		List<Roles> roleList = roleDaoService.procAddRole(role);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;

	}

}
