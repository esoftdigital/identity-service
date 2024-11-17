package com.identity.service.security.services;


import com.identity.service.models.Roles;
import com.identity.service.models.User;
import com.identity.service.models.Users;
import com.identity.service.repository.UserRepository;
import com.identity.service.service.GetUserLoginDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
  @Autowired
  UserRepository userRepository;

  @Autowired
  GetUserLoginDetailService getUserLoginDetailService;

  @Override
  @Transactional
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//    User user = userRepository.findByUsername(username)
//        .orElseThrow(() -> new UsernameNotFoundException("User Not Found with username: " + username));

    User user = getUserLoginDetailService.getUserDetailByUserName(username);
    return UserDetailsImpl.build(user);
  }

}
