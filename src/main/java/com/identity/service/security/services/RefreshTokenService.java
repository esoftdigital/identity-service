package com.identity.service.security.services;


import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import com.identity.service.models.RefreshTokens;
import com.identity.service.models.Users;
import com.identity.service.service.GetUserLoginDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.identity.service.exception.TokenRefreshException;
import com.identity.service.models.RefreshToken;
import com.identity.service.repository.RefreshTokenRepository;
import com.identity.service.repository.UserRepository;

@Service
public class RefreshTokenService {
  @Value("${jwt.app.jwtRefreshExpirationMs}")
  private Long refreshTokenDurationMs;

  @Autowired
  private RefreshTokenRepository refreshTokenRepository;

  @Autowired
  private UserRepository userRepository;

  @Autowired
  GetUserLoginDetailService getUserLoginDetailService;

  public Optional<RefreshTokens> findByToken(String token) {
    Users users = new Users();
    users.setPassword(token);
    return Optional.of(getUserLoginDetailService.getRefreshToken(users));
  }


  public RefreshToken createRefreshToken(Long userId) {
    RefreshToken refreshToken = new RefreshToken();

    refreshToken.setUser(userRepository.findById(userId).get());
    refreshToken.setExpiryDate(new Date(System.currentTimeMillis()+refreshTokenDurationMs));
    refreshToken.setToken(UUID.randomUUID().toString());

    refreshToken = refreshTokenRepository.save(refreshToken);
    return refreshToken;
  }
  public RefreshTokens createRefreshToken(String username, Long userId) {
    RefreshTokens refreshToken = new RefreshTokens();
    Users user = new Users();
    user.setUserId(Integer.parseInt(userId.toString()));
    String token = UUID.randomUUID().toString();
    user.setExpiryDate(new Date(System.currentTimeMillis()+refreshTokenDurationMs));
    user.setPassword(token);
    user.setLoginName(username);
    user.setRequestUserName(username);
    refreshToken = getUserLoginDetailService.insertRefreshToken(user);
    if(refreshToken.getResponseCode().equals("000")){
      refreshToken = getUserLoginDetailService.getRefreshToken(user);
    }
    return refreshToken;
  }

  public RefreshTokens verifyExpiration(RefreshTokens token) {
    Users users = new Users();
    users.setPassword(token.getToken());
    if (token.getExpiryDate().compareTo(new Date(System.currentTimeMillis())) < 0) {
      getUserLoginDetailService.deleteRefreshToken(users);
      throw new TokenRefreshException(token.getToken(), "Refresh token was expired. Please make a new signin request");
    }
    return getUserLoginDetailService.getRefreshToken(users);
  }

  @Transactional
  public int deleteByUserId(Long userId) {
    return refreshTokenRepository.deleteByUser(userRepository.findById(userId).get());
  }
}
