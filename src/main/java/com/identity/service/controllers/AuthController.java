package com.identity.service.controllers;


import com.identity.service.advice.AppException;
import com.identity.service.exception.TokenRefreshException;
import com.identity.service.models.*;
import com.identity.service.payload.request.LoginRequest;
import com.identity.service.payload.request.SignupRequest;
import com.identity.service.payload.request.TokenRefreshRequest;
import com.identity.service.payload.response.JwtResponse;
import com.identity.service.payload.response.MessageResponse;
import com.identity.service.payload.response.TokenRefreshResponse;
import com.identity.service.repository.RoleRepository;
import com.identity.service.repository.RolesRepository;
import com.identity.service.repository.UserRepository;
import com.identity.service.security.jwt.JwtUtils;
import com.identity.service.security.services.RefreshTokenService;
import com.identity.service.security.services.UserDetailsImpl;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/auth")
@Slf4j
public class AuthController {
    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RolesRepository roleRepository;

    @Autowired
    PasswordEncoder encoder;

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    RefreshTokenService refreshTokenService;

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest)
    {
        log.info("Trying to Login Username  {}", loginRequest.getEmail());
        Optional<User> user = loginRequest.getEmail().contains("@") ? userRepository.getByEmail(loginRequest.getEmail())
				: userRepository.findByUsername(loginRequest.getEmail());
        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(user.get().getUsername(), loginRequest.getPassword()));

        Optional<User> users = Optional.ofNullable(new User());
        String jwt = "";
        String success = "";
        RefreshToken refreshToken = null;
        if (authentication.isAuthenticated()) {
            log.info("Trying to  isAuthenticated :  {}", authentication.isAuthenticated());
            success = "success";
            SecurityContextHolder.getContext().setAuthentication(authentication);
            UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
            users = userRepository.findByUsername(userDetails.getUsername());
            jwt = jwtUtils.generateJwtToken(userDetails);

            Set<String> roles = userDetails.getAuthorities().stream().map(item -> item.getAuthority())
                    .collect(Collectors.toSet());

            refreshToken = refreshTokenService.createRefreshToken(userDetails.getId());
        } else
            success = "failed";
        return ResponseEntity.ok(new JwtResponse(success, jwt, refreshToken.getToken(), users));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest)
    {
        if (userRepository.existsByUsername(signUpRequest.getUsername())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Error: Username is already taken!"));
        }

        if (userRepository.existsByEmail(signUpRequest.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Error: Email is already in use!"));
        }

        User user = new User(signUpRequest.getUsername(), signUpRequest.getEmail(),
                encoder.encode(signUpRequest.getPassword()), signUpRequest.getFirst_name(),signUpRequest.getLast_name()
                ,signUpRequest.getPhone(), signUpRequest.getGenderId(), signUpRequest.getChangePasswordAt(),
                signUpRequest.getImage(), signUpRequest.getFullName());

        Set<String> strRoles = signUpRequest.getRole();
        Set<Role> roles = new HashSet<>();

        if (strRoles == null) {
            Role userRole = roleRepository.findByRoleName(signUpRequest.getRole().toString())
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(userRole);
        } else {
            strRoles.forEach(role ->
            {
                switch (role) {
                    case "admin":
                        Role adminRole = roleRepository.findByRoleName(signUpRequest.getRole().toString())
                                .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
                        roles.add(adminRole);

                        break;
                    case "mod":
                        Role modRole = roleRepository.findByRoleName(signUpRequest.getRole().toString())
                                .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
                        roles.add(modRole);

                        break;
                    default:
                        Role userRole = roleRepository.findByRoleName(signUpRequest.getRole().toString())
                                .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
                        roles.add(userRole);
                }
            });
        }

        user.setRoles(roles);
        userRepository.save(user);

        return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
    }

    @PostMapping("/refreshtoken")
    public ResponseEntity<?> refreshtoken(@Valid @RequestBody TokenRefreshRequest request)
    {
        String requestRefreshToken = request.getRefreshToken();

        return refreshTokenService.findByToken(requestRefreshToken)
                .map(refreshTokenService::verifyExpiration)
                .map(RefreshToken::getUser)
                .map(user ->
                {
                    String token = jwtUtils.generateTokenFromUsername(user.getUsername());
                    return ResponseEntity.ok(new TokenRefreshResponse(token, requestRefreshToken));
                })
                .orElseThrow(() -> new TokenRefreshException(requestRefreshToken,
                        "Refresh token is not in database!"));
    }

    @PostMapping("/validateToken")
    public ResponseEntity<UserDto> validateToken(@RequestParam String token)
    {
        log.info("Trying to validate token {}", token);
        String username = jwtUtils.getUserNameFromJwtToken(token);
        log.info("Trying to validate username : {}", username);
        Optional<User> user = userRepository.findByUsername(username);
        if (user.isEmpty()) {
            throw new AppException("User not found", HttpStatus.NOT_FOUND);
        }
        return ResponseEntity.ok(new UserDto(user.get().getId(),"success",token, user));
    }

    @PostMapping("/signout")
    public ResponseEntity<?> logoutUser()
    {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = userDetails.getId();
        refreshTokenService.deleteByUserId(userId);
        return ResponseEntity.ok(new MessageResponse("Log out successful!"));
    }

}
