package com.identity.service.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.identity.service.models.PasswordChange;
import com.identity.service.repository.PasswordChangeRepository;
import com.identity.service.util.Util;

@Service
public class PasswordChangeService {
	
	@Autowired
	PasswordChangeRepository passwordChangeRepository;
	
	
	public PasswordChange changePasswordUser(PasswordChange password) {
		password.setFlagId(Util.PASSWORD_CHANGE_USER);

		List<PasswordChange> roleList = passwordChangeRepository.procAddPasswordChange(password);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;

	}
	public PasswordChange changePasswordClient(PasswordChange password) {
		password.setFlagId(Util.PASSWORD_CHANGE_CLINET);

		List<PasswordChange> roleList = passwordChangeRepository.procAddPasswordChange(password);
		if (roleList.size() > 0)

			return roleList.get(0);
		else
			return null;

	}

}
