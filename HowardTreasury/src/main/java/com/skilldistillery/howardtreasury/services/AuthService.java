package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.entities.User;

public interface AuthService {
	
	public User register(User user);
	public User getUserByUsername(String username);
	public User updateUser(User user);
	public User softDeleteUser(User user);

}
