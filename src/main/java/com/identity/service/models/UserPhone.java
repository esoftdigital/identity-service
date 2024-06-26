package com.identity.service.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserPhone {

    private String phoneNumber;
    private short phoneLineTypeId;
    private short phoneUseTypeId;
    private boolean isPrimaryPhone;

}
