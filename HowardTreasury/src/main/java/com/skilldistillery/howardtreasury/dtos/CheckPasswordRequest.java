package com.skilldistillery.howardtreasury.dtos;

import java.util.Objects;

public class CheckPasswordRequest {
	
    private String token;

    private String newPassword;

	public CheckPasswordRequest() {
		super();
	}

	public CheckPasswordRequest(String token, String newPassword) {
		super();
		this.token = token;
		this.newPassword = newPassword;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	@Override
	public int hashCode() {
		return Objects.hash(newPassword, token);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CheckPasswordRequest other = (CheckPasswordRequest) obj;
		return Objects.equals(newPassword, other.newPassword) && Objects.equals(token, other.token);
	}

	@Override
	public String toString() {
		return "CheckPasswordRequest [token=" + token + ", newPassword=" + newPassword + "]";
	}
    
}
