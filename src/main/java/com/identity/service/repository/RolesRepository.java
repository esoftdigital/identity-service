package com.identity.service.repository;

import com.identity.service.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RolesRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByRoleName(String name);

    boolean existsByRoleName(String name);

    Role getRolesById(Long id);
}
