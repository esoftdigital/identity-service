package com.identity.service.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.identity.service.models.ClientRoles;

@Repository
public interface ClientRoleRepository {
	
	List<ClientRoles> procAddCleintRole(ClientRoles clientRoles);

}
