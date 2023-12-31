package com.skilldistillery.howardtreasury.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
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
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private VerificationTokenService tokenService;
	
	@Override
	public User register(User user) {
	    user.setPassword(encoder.encode(user.getPassword()));
	    user.setEnabled(false);
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
	    
	    // Generate verification token after saving the user
	    String token = tokenService.createVerificationToken(user);

	    // Construct the verification email
	    String recipientAddress = user.getEmail();
	    String subject = "Registration Confirmation";
//	    String confirmationUrl = "http://localhost:8093/verify?token=" + token;
	    String confirmationUrl = "http://localhost:4302/#/verify?token=" + token;
	    String message = "To confirm your e-mail address, please click the link below:\n" + confirmationUrl;

	    // Send the verification email
	    emailService.sendVerificationEmail(recipientAddress, subject, message);
	    
	    return user;
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	@Override
	public User updateUser(User user, String username) {
	    User userUpdate = userRepo.findByUsername(username);

	    if (userUpdate != null) {
	        userUpdate.setUsername(user.getUsername()); // Always set username
	        userUpdate.setPassword(user.getPassword());
	        userUpdate.setEnabled(user.getEnabled());
	        userUpdate.setRole(user.getRole());
	        userUpdate.setEmail(user.getEmail());
	        userUpdate.setImageUrl(user.getImageUrl());

	        return userRepo.save(userUpdate);
	    } else {
	        return null;
	    }
	}
	
	@Override
	public User enable(User userToEnable) {
	    if (userToEnable != null) {
	        userToEnable.setEnabled(true);
	        userRepo.save(userToEnable);
	        return userToEnable;
	    } else {
	        return null;
	    }
	}

	@Override
	public boolean disable(int id) {
		Optional<User> userOpt = userRepo.findById(id);
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			user.setEnabled(false);
			userRepo.saveAndFlush(user);		
		}
		return true;
	}


}
