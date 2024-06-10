package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.VerificationToken;
import com.skilldistillery.howardtreasury.services.AuthService;
import com.skilldistillery.howardtreasury.services.EmailService;
import com.skilldistillery.howardtreasury.services.VerificationTokenService;

@RestController
@CrossOrigin({"*", "http://localhost", "http://34.193.101.27:8080"})
public class AuthController {
	
  @Autowired
  private AuthService authService;
  
  @Autowired
  private VerificationTokenService verificationTokenService;
  
  @Autowired
  private EmailService emailService;
  
	@PostMapping("register")
	public User register(@RequestBody User user, HttpServletResponse res) {
	  if (user == null) {
	     res.setStatus(400);
	     return null;
	  }
	  user = authService.register(user);
	  return user;
	}
	 
	@GetMapping("authenticate")
	public User authenticate(Principal principal, HttpServletResponse res) {
	  if (principal == null) { // no Authorization header sent
	     res.setStatus(401);
	     res.setHeader("WWW-Authenticate", "Basic");
	     return null;
	  }
	  return authService.getUserByUsername(principal.getName());
	}
	
	@PutMapping("users/update")
	public ResponseEntity<User> updateUser(@RequestBody User user, Principal principal, HttpServletResponse res) {
	    if (user == null) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
	    }

	    try {
	        User updatedUser = authService.updateUser(user, principal.getName());
	        return ResponseEntity.ok(updatedUser);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	// Add the following endpoint to handle email verification
	@GetMapping("verify")
	public ResponseEntity<String> verifyAccount(@RequestParam("token") String token) {
	    VerificationToken verificationToken = verificationTokenService.getVerificationToken(token);
	    if (verificationToken == null || verificationToken.getExpiryDate().before(new Date())) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Token is invalid or expired");
	    }
	    User user = verificationToken.getUser();
	    if (user == null) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No user associated with this token");
	    }
	    authService.enable(user);
	    return ResponseEntity.ok("Account verified successfully!");
	}
	
    @DeleteMapping("users/disable")
    public ResponseEntity<String> disableUser(Principal principal, HttpServletResponse res) {
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        boolean disabled = authService.disableUser(principal.getName());
        if (disabled) {
            return ResponseEntity.ok("User disabled successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }
    
    @PostMapping("password-reset-request")
    public ResponseEntity<String> requestPasswordReset(@RequestParam("email") String email) {
        authService.requestPasswordReset(email);
        return ResponseEntity.ok("Password reset email sent.");
    }

    @PostMapping("reset-password")
    public ResponseEntity<String> resetPassword(@RequestParam("token") String token, @RequestParam("password") String password) {
        boolean result = authService.resetPassword(token, password);
        if (result) {
            return ResponseEntity.ok("Password reset successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid or expired token.");
        }
    }

}