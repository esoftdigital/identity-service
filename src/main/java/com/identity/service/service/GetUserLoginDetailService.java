package com.identity.service.service;

import com.identity.service.models.RefreshTokens;
import com.identity.service.models.Roles;
import com.identity.service.models.User;
import com.identity.service.models.Users;
import com.identity.service.repository.GetUserLoginDetailRepository;
import com.identity.service.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetUserLoginDetailService {

    @Autowired
    GetUserLoginDetailRepository getUserLoginDetailRepository;

    public Users getUserLoginDetail(Users user) {

        user.setFlagId(Util.GET_USER_DETAILS);

        return getUserLoginDetailRepository.procAddUser(user).getFirst();
    }

    public User getUserDetailByUserName(String userName) {
        Users user = new Users();
        user.setFlagId(Util.GET_USER_DETAILS_BY_NAME);
        user.setLoginName(userName);
        return getUserLoginDetailRepository.procAddUserByUserName(user).getFirst();
    }
    public RefreshTokens insertRefreshToken(Users user) {
        user.setFlagId(Util.INSERT_REFRESH_TOKEN);
        return getUserLoginDetailRepository.getRefreshToken(user).getFirst();
    }
    public RefreshTokens getRefreshToken(Users user) {
        user.setFlagId(Util.GET_REFRESH_TOKEN);
        return getUserLoginDetailRepository.getRefreshToken(user).getFirst();
    }

    public RefreshTokens deleteRefreshToken(Users user) {
        user.setFlagId(Util.DELETE_REFRESH_TOKEN);
        return getUserLoginDetailRepository.getRefreshToken(user).getFirst();
    }

    public Optional<Users> getUserLoginDetails(Users user) {

        user.setFlagId(Util.GET_USER_DETAILS);

        return Optional.ofNullable(getUserLoginDetailRepository.procAddUser(user).getFirst());
    }

    public Roles getUserLoginRoleDetails(Users user) {
        user.setFlagId(Util.GET_USER_ROLE);
        return getUserLoginDetailRepository.procAddUserRoles(user).getFirst();
    }

}
