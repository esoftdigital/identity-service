package com.identity.service.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.identity.service.models.Users;
import com.identity.service.service.UserService;


@RestController
@RequestMapping("/api/user")
public class UserConteroller {

	@Autowired
	UserService userService;
	
	@Autowired
    PasswordEncoder encoder;

	@PostMapping("/save")
	public ResponseEntity<?> createUsers(@RequestBody Users users) {
		
		users.setPassword(encoder.encode(users.getPassword()));
		
		List<Map<String, Object>> savedUser = userService.userSave(users);

		return new ResponseEntity<>(savedUser, HttpStatus.CREATED);
	}

	@GetMapping("/constants")
	public Map<String, Object> getConstants() {
		Map<String, Object> constants = userService.getUserConstants();

		return constants;
	}
	
	@GetMapping("/userId")
	public Map<String, Object> getUserId() {
		Map<String, Object> constants = userService.getUserId();

		return constants;
	}

	@GetMapping("/getCountry")
	public List<Map<String, Object>> getCountry() {
		Users users = new Users();
		return userService.getCountry(users);
	}

	@GetMapping("/getClient/{countryId}")
	public List<Map<String, Object>> getClient(@PathVariable(name = "countryId", required = true) short countryId) {
		Users users = new Users();
		users.setCountryId(countryId);
		return userService.getClient(users);
	}

	@GetMapping("/getLocationType/{countryId}")
	public List<Map<String, Object>> getLocationType(
			@PathVariable(name = "countryId", required = true) short countryId) {
		Users users = new Users();
		users.setCountryId(countryId);
		return userService.getUserLocationType(users);
	}

	@GetMapping("/getLocation/{countryId}/{clientId}/{locationTypeId}")
	public List<Map<String, Object>> getLocation(@PathVariable(name = "countryId", required = true) short countryId,
			@PathVariable(name = "clientId", required = true) short clientId,
			@PathVariable(name = "locationTypeId", required = true) short locationTypeId) {
		Users users = new Users();
		users.setCountryId(countryId);
		users.setClientId(clientId);
		users.setLocationTypeId(locationTypeId);
		return userService.getUserLocation(users);
	}

	@GetMapping("/getGeographyType/{countryId}")
	public List<Map<String, Object>> getGeographyType(
			@PathVariable(name = "countryId", required = true) short countryId) {
		Users users = new Users();
		users.setCountryId(countryId);
		return userService.getUserGeograpyType(users);
	}

	@GetMapping("/getGeography/{countryId}/{geographyTypeId}")
	public List<Map<String, Object>> getGeography(@PathVariable(name = "countryId", required = true) short countryId,
			@PathVariable(name = "geographyTypeId", required = true) short geographyTypeId) {
		Users users = new Users();
		users.setCountryId(countryId);
		users.setGeographyTypeId(geographyTypeId);
		return userService.getUserGeograpy(users);
	}

	@GetMapping("/checkAvailablity/{countryId}/{clientId}/{loginName}")
	public List<Map<String, Object>> checkAvailablity(
			@PathVariable(name = "countryId", required = true) short countryId,
			@PathVariable(name = "clientId", required = true) short clientId,
			@PathVariable(name = "loginName", required = true) String loginName) {
		Users users = new Users();
		users.setCountryId(countryId);
		users.setClientId(clientId);
		users.setLoginName(loginName);
		return userService.getUserCheckAvailability(users);
	}

}
