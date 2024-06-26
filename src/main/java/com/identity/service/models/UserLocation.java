package com.identity.service.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserLocation {

    private Integer geographyId;
    private String addressLine1;
    private String addressLine2;
    private String addressLine3;
    private String city;
    private short addressTypeId;
    private String locality;
    private String postalCode;
    private Boolean isPrimaryLocation;
}
