package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.dtos.UserDTO;
import com.skilldistillery.howardtreasury.entities.User;

public interface UserService {
	
	public UserDTO mapUserToDTO(User user);

}
