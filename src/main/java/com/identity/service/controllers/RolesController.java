package com.identity.service.controllers;


import com.identity.service.exception.RoleNotFoundException;
import com.identity.service.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.identity.service.models.Roles;
import com.identity.service.payload.response.MessageResponse;
import com.identity.service.repository.RoleRepository;

import jakarta.validation.Valid;

import java.util.List;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/roles")
public class RolesController {

	@Autowired
	RoleService roleService;
	
	@PostMapping("/save")
	@PreAuthorize("hasRole('ADMIN')")
	public ResponseEntity<?> createRoles(@Valid @RequestBody Roles roles){

		Roles savedRole = roleService.save(roles);

		return new ResponseEntity<>(savedRole, HttpStatus.CREATED);
	}
	
//	@DeleteMapping("/{id}")
//	@PreAuthorize("hasRole('ADMIN')")
//	public ResponseEntity<?> deleteRoles(@PathVariable("id") Long id) {
//
//		if (roleRepository.existsById(id)) {
//			roleRepository.deleteById(id);
//		} else {
//			return ResponseEntity.badRequest().body(new MessageResponse("Error: RoleId Not Found"));
//		}
//
//		return ResponseEntity.ok(new MessageResponse("Deleted Successfully."));
//	}
	
/*	@GetMapping("/{id}")
	@PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
	public ResponseEntity<Roles> getRole(@PathVariable short id) {

		Roles role = roleService.findOne(id);
		if (role == null)
			throw new RoleNotFoundException("Role Not found for given id=" + id);
		return new ResponseEntity<>(role, HttpStatus.OK);
	}*/

	@GetMapping
	@PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
	public ResponseEntity<?> getAllRoles() {

		List<Roles> roleList = roleService.findAll();
		if (roleList.isEmpty())
			throw new RoleNotFoundException("No Roles is configured currently");
		return new ResponseEntity<>(roleList, HttpStatus.OK);
	}
	
	@PutMapping("/update")
	@PreAuthorize("hasRole('ADMIN')")
	public ResponseEntity<?> updateRole(@RequestBody Roles role) {
		Roles savedRole = roleService.update(role);
		return new ResponseEntity<>(savedRole, HttpStatus.CREATED);
	}

}
