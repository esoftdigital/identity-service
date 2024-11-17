package com.identity.service.repository;

import com.identity.service.models.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GetUserLoginDetailRepository {

    List<Users> procAddUser(Users users);

    List<Roles> procAddUserRoles(Users users);

    List<User> procAddUserByUserName(Users users);

    List<RefreshTokens> getRefreshToken(Users user);
}
