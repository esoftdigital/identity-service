package com.identity.service.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.identity.service.models.Users;

@Service
public interface UsersRepository {
	
	List<Map<String, Object>> procAddUsers(Users user);
	
	Map<String, Object> procConstants(Users user);

}
