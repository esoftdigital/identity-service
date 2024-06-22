package com.identity.service.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.identity.service.models.PasswordChange;

@Repository
public interface PasswordChangeRepository {

	List<PasswordChange> procAddPasswordChange(PasswordChange paaswordChange);
}
