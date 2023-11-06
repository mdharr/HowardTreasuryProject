package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private UserListService userListService;
	
	@Override
	public User register(User user) {
	    user.setPassword(encoder.encode(user.getPassword()));
	    user.setEnabled(true);
	    user.setRole("STANDARD");
	    user.setEmail(user.getEmail());
	    user.setImageUrl(user.getImageUrl());
	    
	    // Save the user first to generate a user ID
	    user = userRepo.saveAndFlush(user);
	    
	    // Create a new user list for the registered user
	    UserList userList = new UserList();
	    userList.setUser(user); // Set the user for the list
	    userList.setName("Favorites"); // Set a default name for the list
	    
	    // Save the user list
	    userListService.create(user.getUsername(), userList);
	    
	    return user;
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}

}
