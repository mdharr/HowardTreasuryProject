package com.skilldistillery.howardtreasury.dtos;

import java.util.Objects;

public class UserDTO {
    private int id;
    private String username;
    private Boolean enabled;
    private String role;
    private String email;
	public UserDTO() {
		super();
	}
	public UserDTO(int id, String username, Boolean enabled, String role, String email) {
		super();
		this.id = id;
		this.username = username;
		this.enabled = enabled;
		this.role = role;
		this.email = email;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Boolean getEnabled() {
		return enabled;
	}
	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserDTO other = (UserDTO) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", username=" + username + ", enabled=" + enabled + ", role=" + role + ", email="
				+ email + "]";
	}

}

