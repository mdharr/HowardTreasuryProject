package com.skilldistillery.howardtreasury.services;

import java.util.Date;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.ResetPasswordToken;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.exceptions.EmailAlreadyExistsException;
import com.skilldistillery.howardtreasury.exceptions.UserDeactivatedException;
import com.skilldistillery.howardtreasury.exceptions.UsernameAlreadyExistsException;
import com.skilldistillery.howardtreasury.exceptions.UsernameNotFoundException;
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
	
	@Autowired
    private ResetPasswordTokenService resetPasswordTokenService;
	
    @Autowired
    private PasswordEncoder passwordEncoder;
	
	@Override
	public User register(User user) {
		
        if (userRepo.findByUsername(user.getUsername()) != null) {
            throw new UsernameAlreadyExistsException("Username already exists");
        }

        if (userRepo.findByEmail(user.getEmail()) != null) {
            throw new EmailAlreadyExistsException("Email already exists");
        }
		
	    System.out.println("Starting registration process for: " + user.getEmail());
	    user.setPassword(encoder.encode(user.getPassword()));
	    user.setEnabled(false);
	    user.setRole("STANDARD");
	    user.setEmail(user.getEmail());
	    user.setImageUrl(user.getImageUrl());
	    user.setDeactivated(false);

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
    public User login(String username) {
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
//        if (!user.getEnabled()) {
//            throw new UserNotEnabledException("User account is not enabled");
//        }
        // Allow login even if the account is deactivated
        return user;
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

    @Override
    public void requestPasswordReset(String email) {
        User user = userRepo.findByEmail(email);
        if (user != null) {
        	String recipientAddress = email;
        	String subject = "Reset password instructions\n";
            String token = resetPasswordTokenService.createPasswordResetToken(user);
            String resetUrl = "http://localhost:4304/#/reset/" + token;
//            String resetUrl = "http://localhost:4304/#/reset?token=" + token;
//            String resetUrl = "http://34.193.101.27:8080/HowardTreasury/#/verify?token=" + token;
//            String message = "Hello " + recipientAddress + "!" + "\n" + "\n" + "Someone has requested a link to change your password. You can do this through the link below." + "\n" + "\n" + resetUrl + "\n" + "\n" + "If you didn't request this, please ignore this email." + "\n" + "\n" + "Your password won't change until you access the link above and create a new one." + "\n";
            
            String message = "<html><body>"
                    + "<p>Hello " + recipientAddress + "!</p>"
                    + "<p>Someone has requested a link to change your password. You can do this through the link below.</p>"
                    + "<p><a href=\"" + resetUrl + "\">Change my password</a></p>"
                    + "<p>If you didn't request this, please ignore this email.</p>"
                    + "<p>Your password won't change until you access the link above and create a new one.</p>"
                    + "</body></html>";
            
    	    // Send the verification email
    	    try {
//                emailService.sendResetPasswordEmail(recipientAddress, subject, message);
                emailService.sendHtmlEmail(recipientAddress, subject, message);
//    	        System.out.println("Password reset email sent to: " + recipientAddress);
    	    } catch (Exception e) {
    	        System.err.println("Error sending password reset email: " + e.getMessage());
    	        e.printStackTrace();
    	        throw e;
    	    }
        }
    }

    @Override
    public boolean resetPassword(String token, String newPassword) {
        ResetPasswordToken resetToken = resetPasswordTokenService.getResetPasswordToken(token);
        if (resetToken == null || resetToken.getExpiryDate().before(new Date())) {
            return false; // Token is invalid or expired
        }
        User user = resetToken.getUser();
        if (user != null) {
            user.setPassword(encoder.encode(newPassword));
            userRepo.save(user);
            resetPasswordTokenService.deleteResetPasswordToken(token); // Delete the token after resetting the password
            return true;
        }
        return false;
    }
    
    @Override
    public boolean checkPassword(String token, String newPassword) {
        ResetPasswordToken resetToken = resetPasswordTokenService.getResetPasswordToken(token);
        if (resetToken != null) {
            User user = resetToken.getUser();
            if (user != null) {
                return passwordEncoder.matches(newPassword, user.getPassword());
            }
        }
        throw new RuntimeException("Invalid token");
    }
    
	
    @Override
    public boolean isAccountDeactivated(String username) {
        User user = userRepo.findByUsername(username);
        return user != null && user.getDeactivated();
    }
}
