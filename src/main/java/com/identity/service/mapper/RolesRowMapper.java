package com.identity.service.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.identity.service.models.Roles;
import org.springframework.jdbc.core.RowMapper;



public class RolesRowMapper implements RowMapper<Roles> {

    @Override
    public Roles mapRow(ResultSet rs, int rowNum) throws SQLException {
        Roles roles = new Roles();

        roles.setResponseCode(rs.getString("ResponseCode"));
        roles.setResponseString(rs.getString("ResponseString"));
        roles.setRoleId(rs.getShort("RoleId"));
        roles.setRoleName(rs.getString("RoleName"));
        roles.setRoleCode(rs.getString("RoleCode"));
        roles.setRoleDescription(rs.getString("RoleDescription"));
        roles.setRequestDate(rs.getString("RequestDate"));
        roles.setRequestUserName(rs.getString("RequestUserName"));
        roles.setIsDisabled(Boolean.parseBoolean(rs.getString("Status")));

        return roles;
    }

}

