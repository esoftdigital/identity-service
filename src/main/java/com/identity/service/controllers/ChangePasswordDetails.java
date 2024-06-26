package com.identity.service.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.identity.service.models.PasswordChange;
import com.identity.service.service.PasswordChangeService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/password")
public class ChangePasswordDetails {
	
	@Autowired
	PasswordChangeService passwordChangeService;
	@Autowired
    PasswordEncoder encoder;


	@PostMapping("/user/change")
	public ResponseEntity<?> userPasswordChange(@Valid @RequestBody PasswordChange passwordChange) {

		passwordChange.setOldPassword(encoder.encode(passwordChange.getOldPassword()));
		passwordChange.setNewPassword(encoder.encode(passwordChange.getNewPassword()));
		
		
		PasswordChange changePassword = passwordChangeService.changePasswordUser(passwordChange);

		return new ResponseEntity<>(changePassword, HttpStatus.OK);
	}

	@PostMapping("/client/change")
	public ResponseEntity<?> clientPasswordChange(@Valid @RequestBody PasswordChange passwordChange) {
		passwordChange.setOldPassword(encoder.encode(passwordChange.getOldPassword()));
		passwordChange.setNewPassword(encoder.encode(passwordChange.getNewPassword()));
		
		PasswordChange changePassword = passwordChangeService.changePasswordClient(passwordChange);

		return new ResponseEntity<>(changePassword, HttpStatus.OK);
	}
}
