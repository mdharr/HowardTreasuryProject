package com.skilldistillery.howardtreasury.services;

import java.util.Optional;

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
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private VerificationTokenService tokenService;
	
//	@Override
//	public User register(User user) {
//	    user.setPassword(encoder.encode(user.getPassword()));
//	    user.setEnabled(false);
//	    user.setRole("STANDARD");
//	    user.setEmail(user.getEmail());
//	    user.setImageUrl(user.getImageUrl());
//	    
//	    // Save the user first to generate a user ID
//	    user = userRepo.saveAndFlush(user);
//	    
//	    // Create a new user list for the registered user
//	    UserList userList = new UserList();
//	    userList.setUser(user); // Set the user for the list
//	    userList.setName("Favorites"); // Set a default name for the list
//	    
//	    // Save the user list
//	    userListService.create(user.getUsername(), userList);
//	    
//	    // Generate verification token after saving the user
//	    String token = tokenService.createVerificationToken(user);
//
//	    // Construct the verification email
//	    String recipientAddress = user.getEmail();
//	    String subject = "Registration Confirmation";
////	    String confirmationUrl = "http://localhost:8093/verify?token=" + token;
////	    String confirmationUrl = "http://localhost:4304/#/verify?token=" + token;
//	    String confirmationUrl = "http://34.193.101.27:8080/HowardTreasury/#/verify?token=" + token;
//	    String message = "To confirm your e-mail address, please click the link below:\n" + confirmationUrl;
//
//	    // Send the verification email
//	    emailService.sendVerificationEmail(recipientAddress, subject, message);
//	    
//	    return user;
//	}
	
	@Override
	public User register(User user) {
	    System.out.println("Starting registration process for: " + user.getEmail());
	    user.setPassword(encoder.encode(user.getPassword()));
	    user.setEnabled(false);
	    user.setRole("STANDARD");
	    user.setEmail(user.getEmail());
	    user.setImageUrl(user.getImageUrl());

	    // Save the user first to generate a user ID
	    try {
	        user = userRepo.saveAndFlush(user);
	        System.out.println("User saved with ID: " + user.getId());
	    } catch (Exception e) {
	        System.err.println("Error saving user: " + e.getMessage());
	        e.printStackTrace();
	        throw e;
	    }

	    // Create a new user list for the registered user
	    UserList userList = new UserList();
	    userList.setUser(user); // Set the user for the list
	    userList.setName("Favorites"); // Set a default name for the list

	    // Save the user list
	    try {
	        userListService.create(user.getUsername(), userList);
	        System.out.println("User list created for user: " + user.getUsername());
	    } catch (Exception e) {
	        System.err.println("Error creating user list: " + e.getMessage());
	        e.printStackTrace();
	        throw e;
	    }

	    // Generate verification token after saving the user
	    String token;
	    try {
	        token = tokenService.createVerificationToken(user);
	        System.out.println("Generated token: " + token);
	    } catch (Exception e) {
	        System.err.println("Error generating token: " + e.getMessage());
	        e.printStackTrace();
	        throw e;
	    }

	    // Construct the verification email
	    String recipientAddress = user.getEmail();
	    String subject = "Registration Confirmation";
//	    String confirmationUrl = "http://localhost:4304/#/verify?token=" + token;
	    String confirmationUrl = "http://34.193.101.27:8080/HowardTreasury/#/verify?token=" + token;
	    String message = "To verify your e-mail address, please click the link below:\n" + confirmationUrl;

	    // Send the verification email
	    try {
	        emailService.sendVerificationEmail(recipientAddress, subject, message);
	        System.out.println("Verification email sent to: " + recipientAddress);
	    } catch (Exception e) {
	        System.err.println("Error sending verification email: " + e.getMessage());
	        e.printStackTrace();
	        throw e;
	    }

	    System.out.println("Registration process completed for: " + user.getEmail());
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
	        userUpdate.setProfileDescription(user.getProfileDescription());

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
	
    @Override
    public boolean disableUser(String username) {
        User user = userRepo.findByUsername(username);
        if (user != null) {
            user.setEnabled(false); // Disable the user account
            userRepo.save(user);
            return true;
        }
        return false;
    }

}
