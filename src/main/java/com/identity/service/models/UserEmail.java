package com.identity.service.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserEmail {

    private String emailAddress;
    private short emailTypeId;
    private short emailUseTypeId;
    private boolean isPrimaryEmail;

}
