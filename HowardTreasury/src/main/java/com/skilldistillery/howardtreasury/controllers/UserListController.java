package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.services.AuthService;
import com.skilldistillery.howardtreasury.services.UserListService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class UserListController {

	@Autowired
	private UserListService userListService;
	
	@Autowired
	private AuthService authService;
	
	@GetMapping("users/{uid}/lists")
	public List<UserList> getAllUserLists(@PathVariable("uid") int userId, Principal principal, HttpServletRequest req, HttpServletResponse res) {
		return userListService.findAll(principal.getName());
	}
	
    @GetMapping("users/{uid}/lists/{listId}")
    public ResponseEntity<UserList> getUserList(
            @PathVariable("uid") int userId,
            @PathVariable("listId") int listId,
            Principal principal) {
        UserList userList = userListService.find(principal.getName(), listId);
        if (userList != null) {
            return new ResponseEntity<>(userList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("users/{uid}/lists")
    public ResponseEntity<UserList> createUserList(
            @PathVariable("uid") int userId,
            @RequestBody UserList userList) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        // Ensure the user is authenticated.
        if (authentication != null && authentication.isAuthenticated()) {
            // Retrieve the username from the authentication object.
            String username = authentication.getName();
            
            // Fetch the User entity based on the username (or ID) from your user repository.
            User user = authService.getUserByUsername(username);
            
            if (user != null) {
                userList.setUser(user); // Set the associated user.
                UserList createdUserList = userListService.create(username, userList);
                if (createdUserList != null) {
                    return new ResponseEntity<>(createdUserList, HttpStatus.CREATED);
                }
            }
        }
        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }


    @PutMapping("users/{uid}/lists/{listId}")
    public ResponseEntity<UserList> updateUserList(
            @PathVariable("uid") int userId,
            @PathVariable("listId") int listId,
            @RequestBody UserList userList,
            Principal principal) {
        UserList updatedUserList = userListService.update(principal.getName(), listId, userList);
        if (updatedUserList != null) {
            return new ResponseEntity<>(updatedUserList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("users/{uid}/lists/{listId}")
    public ResponseEntity<Void> deleteUserList(
            @PathVariable("uid") int userId,
            @PathVariable("listId") int listId,
            Principal principal) {
        userListService.delete(principal.getName(), listId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
	
}
