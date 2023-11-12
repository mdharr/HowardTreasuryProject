package com.skilldistillery.howardtreasury.dtos;

import java.util.Objects;

public class SimpleUserDTO {
	
    private int id;
    
    private String username;

    public SimpleUserDTO() {}

    public SimpleUserDTO(int id, String username) {
        this.id = id;
        this.username = username;
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
		SimpleUserDTO other = (SimpleUserDTO) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "SimpleUserDTO [id=" + id + ", username=" + username + "]";
	}
    
}
