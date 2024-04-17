package com.identity.service.payload.response;

import com.identity.service.models.User;
import lombok.*;

import java.util.Optional;


@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class JwtResponse {

	private String status;
	private String token;
	private String type = "Bearer";
	private String refreshToken;
	private Optional<User> data;

	public JwtResponse(String status, String token, String refreshToken, Optional<User> data){
		this.status=status;
		this.token  =token;
		this.refreshToken=refreshToken;
		this.data=data;
	}

}
