package com.identity.service.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.identity.service.models.Users;
import com.identity.service.repository.UsersRepository;
import com.identity.service.util.Util;

import jakarta.validation.Valid;

@Service
public class UserService {
	
	@Autowired
	UsersRepository userDaoService;
	
	public Map<String, Object> getUserId() {
		// TODO Auto-generated method stub
		Users user = new Users();
		user.setFlagId(Util.USER_USERID_FLAG);
		
		return userDaoService.procConstants(user);
	}
	
	public Map<String, Object> getUserConstants() {
		// TODO Auto-generated method stub
		Users user = new Users();
		user.setFlagId(Util.USER_CONST_FLAG);
		
		return userDaoService.procConstants(user);
	}

	public List<Map<String, Object>> getCountry(@Valid Users users) {
		// TODO Auto-generated method stub
		users.setFlagId(Util.USER_COUNTRY_FLAG);
		return userDaoService.procAddUsers(users);
	}
	
	public List<Map<String, Object>> getClient(@Valid Users user) {
		// TODO Auto-generated method stub
		user.setFlagId(Util.USER_CLIENT_FLAG);
		
		return userDaoService.procAddUsers(user);
	}
	
	
	public List<Map<String, Object>> getUserLocationType(@Valid Users user) {
		// TODO Auto-generated method stub
		
		user.setFlagId(Util.USER_LOCATION_TYPE_FLAG);
		
		return userDaoService.procAddUsers(user);
	}

    
	
	public List<Map<String, Object>> getUserLocation(@Valid Users user) {
		// TODO Auto-generated method stub
		user.setFlagId(Util.USER_LOCATION_FLAG);
		
		return userDaoService.procAddUsers(user);
	}

	
	public List<Map<String, Object>> getUserGeograpyType(@Valid Users user) {
		// TODO Auto-generated method stub
		user.setFlagId(Util.USER_GEOGRAPY_TYPE_FLAG);
		
		return userDaoService.procAddUsers(user);
	}

	
	public List<Map<String, Object>> getUserGeograpy(@Valid Users user) {
		// TODO Auto-generated method stub
		user.setFlagId(Util.USER_GEOGRAPY_FLAG);
		
		return userDaoService.procAddUsers(user);
	}
 	
	public List<Map<String, Object>> getUserCheckAvailability(@Valid Users user) {
		// TODO Auto-generated method stub
		user.setFlagId(Util.USER_CHECK_AVAILABILITY_FLAG);
		
		return userDaoService.procAddUsers(user);
	}

	public List<Map<String, Object>> userSave(Users user) {
		// TODO Auto-generated method stub

		user.setFlagId(Util.USER_SAVE_FLAG);
		
		return userDaoService.procAddUsers(user);
	}

	

}
