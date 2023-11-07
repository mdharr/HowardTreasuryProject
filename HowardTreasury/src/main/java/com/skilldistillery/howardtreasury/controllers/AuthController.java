package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.VerificationToken;
import com.skilldistillery.howardtreasury.services.AuthService;
import com.skilldistillery.howardtreasury.services.VerificationTokenService;

@RestController
@CrossOrigin({"*", "http://localhost"})
public class AuthController {
	
  @Autowired
  private AuthService authService;
  
  @Autowired
  private VerificationTokenService verificationTokenService;
  
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

}