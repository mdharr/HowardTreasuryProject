package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.dtos.UserDTO;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.WeirdTales;

public interface UserService {
	
	public UserDTO mapUserToDTO(User user);

	public User find(int userId);
	
}
