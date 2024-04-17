package com.identity.service.repository;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.identity.service.models.Roles;


@Repository
public interface RoleRepository {
	//Optional<Roles> findByRoleName(String name);

	//boolean existsByRoleName(String name);

	//Roles getRolesById(Long id);

	List<Roles> procAddRole(Roles roles);
}
