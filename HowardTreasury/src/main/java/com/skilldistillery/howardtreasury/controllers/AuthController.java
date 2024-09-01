package com.skilldistillery.howardtreasury.controllers;

import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.dtos.CheckPasswordRequest;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.VerificationToken;
import com.skilldistillery.howardtreasury.exceptions.EmailAlreadyExistsException;
import com.skilldistillery.howardtreasury.exceptions.RateLimitExceededException;
import com.skilldistillery.howardtreasury.exceptions.UserDeactivatedException;
import com.skilldistillery.howardtreasury.exceptions.UsernameAlreadyExistsException;
import com.skilldistillery.howardtreasury.exceptions.UsernameNotFoundException;
import com.skilldistillery.howardtreasury.services.AuthService;
import com.skilldistillery.howardtreasury.services.EmailService;
import com.skilldistillery.howardtreasury.services.RateLimitService;
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
  
  @Autowired
  private RateLimitService rateLimitService;
  
//  Previous register method
//	@PostMapping("register")
//	public User register(@RequestBody User user, HttpServletResponse res) {
//	  if (user == null) {
//	     res.setStatus(400);
//	     return null;
//	  }
//	  user = authService.register(user);
//	  return user;
//	}
  
  	@PostMapping("register")
  	public ResponseEntity<?> register(@RequestBody User user) {
      try {
          User registeredUser = authService.register(user);
          return new ResponseEntity<>(registeredUser, HttpStatus.OK);
      } catch (UsernameAlreadyExistsException e) {
          return new ResponseEntity<>(e.getMessage(), HttpStatus.CONFLICT);
      } catch (EmailAlreadyExistsException e) {
          return new ResponseEntity<>(e.getMessage(), HttpStatus.CONFLICT);
      } catch (Exception e) {
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  	}

	 
//	@GetMapping("authenticate")
//	public User authenticate(Principal principal, HttpServletResponse res) {
//	  if (principal == null) { // no Authorization header sent
//	     res.setStatus(401);
//	     res.setHeader("WWW-Authenticate", "Basic");
//	     return null;
//	  }
//	  return authService.getUserByUsername(principal.getName());
//	}
	
//    @GetMapping("authenticate")
//    public ResponseEntity<?> auth(Principal principal) {
//        if (principal == null) { // no Authorization header sent
//            HttpHeaders headers = new HttpHeaders();
//            headers.set("WWW-Authenticate", "Basic");
//            return new ResponseEntity<>(headers, HttpStatus.UNAUTHORIZED);
//        }
//        try {
//            User user = authService.login(principal.getName());
//            return new ResponseEntity<>(user, HttpStatus.OK);
//        } catch (UsernameNotFoundException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
//        } catch (UserDeactivatedException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.FORBIDDEN);
//        } catch (Exception e) {
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
  	
  	// working version
//    @GetMapping("authenticate")
//    public ResponseEntity<?> auth(Principal principal) {
//        if (principal == null) { // no Authorization header sent
//            HttpHeaders headers = new HttpHeaders();
//            headers.set("WWW-Authenticate", "Basic");
//            return new ResponseEntity<>(headers, HttpStatus.UNAUTHORIZED);
//        }
//        try {
//            User user = authService.login(principal.getName());
////            if (authService.isAccountDeactivated(principal.getName())) {
////                return new ResponseEntity<>("User account is deactivated", HttpStatus.FORBIDDEN);
////            }
//            return new ResponseEntity<>(user, HttpStatus.OK);
//        } catch (UsernameNotFoundException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
//        } catch (Exception e) {
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
  	
  	// experimental
  	@GetMapping("authenticate")
  	public ResponseEntity<?> auth(Principal principal) {
  	    if (principal == null) {
  	        return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
  	    }

  	    try {
  	        User user = authService.getUserDetails(principal.getName());
  	        return new ResponseEntity<>(user, HttpStatus.OK);
  	    } catch (UsernameNotFoundException e) {
  	        return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
  	    } catch (Exception e) {
  	        return new ResponseEntity<>("An error occurred", HttpStatus.INTERNAL_SERVER_ERROR);
  	    }
  	}
  	
//    @GetMapping("authentication")
//    public ResponseEntity<?> auth(Principal principal) {
//        if (principal == null) { // no Authorization header sent
//            HttpHeaders headers = new HttpHeaders();
//            headers.set("WWW-Authenticate", "Basic");
//            return new ResponseEntity<>(headers, HttpStatus.UNAUTHORIZED);
//        }
//        try {
//            User user = authService.login(principal.getName());
//            Map<String, Object> response = new HashMap<>();
//            response.put("user", user);
//            response.put("deactivated", authService.isAccountDeactivated(principal.getName()));
//            return new ResponseEntity<>(response, HttpStatus.OK);
//        } catch (UsernameNotFoundException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
//        } catch (Exception e) {
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }

    @PostMapping("send-activation-email")
    public ResponseEntity<?> sendActivationEmail(@RequestParam String username) {
        authService.sendActivationEmail(username);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("verify-activation-code")
    public ResponseEntity<?> verifyActivationCode(@RequestParam String username, @RequestParam String code) {
        boolean success = authService.verifyActivationCode(username, code);
        if (success) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Invalid or expired activation code", HttpStatus.BAD_REQUEST);
        }
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
    public ResponseEntity<Map<String, String>> requestPasswordReset(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        authService.requestPasswordReset(email);
        Map<String, String> response = new HashMap<>();
        response.put("message", "Password reset email sent.");
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
            .body(response);
    }
    
    @PostMapping("reset-password")
    public ResponseEntity<Map<String, String>> resetPassword(@RequestBody Map<String, String> request) {
        String token = request.get("token");
        String password = request.get("password");
        boolean result = authService.resetPassword(token, password);
        Map<String, String> response = new HashMap<>();
        if (result) {
            response.put("message", "Password reset successfully.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "Invalid or expired token.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
    
    @PostMapping("check-password")
    public ResponseEntity<Boolean> checkPassword(@RequestBody CheckPasswordRequest request) {
        try {
            if (request.getToken() == null || request.getNewPassword() == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false);
            }
            
            boolean passwordsMatch = authService.checkPassword(request.getToken(), request.getNewPassword());
            return ResponseEntity.ok(passwordsMatch);
        } catch (Exception e) {
            e.printStackTrace(); // Log the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
        }
    }


}