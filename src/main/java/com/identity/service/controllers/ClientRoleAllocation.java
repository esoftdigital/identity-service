package com.identity.service.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.mapper.RList;
import com.identity.service.models.ClientRoles;
import com.identity.service.service.ClientRoleService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/client")
public class ClientRoleAllocation {

	@Autowired
	ClientRoleService clientRoleService;

	@GetMapping("/getClients/{countryId}")
	public ResponseEntity<?> getClient(@PathVariable(name = "countryId", required = true) short countryId) {

		List<ClientRoles> roleList = clientRoleService.getClients(countryId);
		if (roleList.isEmpty())
			throw new RoleNotFoundException("No Roles is configured currently");
		return new ResponseEntity<>(roleList, HttpStatus.OK);
	}

	@GetMapping("/getCountry")
	public ResponseEntity<?> getClientRole() {

		List<ClientRoles> roleList = clientRoleService.getCountry();
		if (roleList.isEmpty())
			throw new RoleNotFoundException("No Roles is configured currently");
		return new ResponseEntity<>(roleList, HttpStatus.OK);
	}

	@PostMapping("/save")
	public ResponseEntity<?> createRoles(@Valid @RequestBody ClientRoles roles) {

		ClientRoles savedRole = clientRoleService.save(roles);

		return new ResponseEntity<>(savedRole, HttpStatus.CREATED);
	}

	@GetMapping("/getClientAllRoles/{clientId}")
	public ResponseEntity<?> getAllClientRoles(@PathVariable(name = "clientId", required = true) short clientId) {

		List<ClientRoles> roleList = clientRoleService.getAllClientRoles(clientId);
		Map<String, Object> map = new HashMap<>();
		map.put("options", getNotSelectList(roleList));
		map.put("selected", getSelectedList(roleList));

		if (roleList.isEmpty())
			throw new RoleNotFoundException("No Roles is configured currently");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	private List<String> getSelectedList(List<ClientRoles> roleList) {
		List<String> list = new ArrayList<>();
		roleList.stream().forEach(e -> {
			if (e.getClientRoleId() != 0) {
				list.add(String.valueOf(e.getRoleId()));
			}
		});
		return list;
	}

	private List<RList> getNotSelectList(List<ClientRoles> roleList) {

		return roleList.stream().map(e -> new RList(e.getRoleId(), e.getRoleName())).collect(Collectors.toList());

	}

}
