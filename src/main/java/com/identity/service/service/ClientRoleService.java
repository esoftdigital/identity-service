package com.identity.service.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.identity.service.models.ClientRoles;
import com.identity.service.repository.ClientRoleRepository;
import com.identity.service.util.Util;

@Service
public class ClientRoleService {

	@Autowired
	ClientRoleRepository clientRoleRepository;

	public List<ClientRoles> getClients(short countryId) {
		ClientRoles roles = new ClientRoles();
		roles.setFlagId(Util.CLIENT_ROLE_GET_CLIENT);
		roles.setCountryId(countryId);
		return clientRoleRepository.procAddCleintRole(roles);
	}

	public List<ClientRoles> getCountry() {
		ClientRoles roles = new ClientRoles();
		roles.setFlagId(Util.CLIENT_ROLE_GET_COUNTRY);
		return clientRoleRepository.procAddCleintRole(roles);
	}

	public List<ClientRoles> getAllClientRoles(short clientId) {
		ClientRoles roles = new ClientRoles();
		roles.setClientId(clientId);
		roles.setFlagId(Util.CLIENT_ROLE_GET_ALL);
		return clientRoleRepository.procAddCleintRole(roles);
	}

	public ClientRoles save(ClientRoles role) {
		role.setFlagId(Util.CLIENT_ROLE_SAVE_CLIENT_ROLE);

		List<ClientRoles> roleList = clientRoleRepository.procAddCleintRole(role);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;

	}

}
