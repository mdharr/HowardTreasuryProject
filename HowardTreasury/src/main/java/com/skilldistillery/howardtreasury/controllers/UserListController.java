package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@GetMapping("lists")
    public ResponseEntity<List<UserList>> getAllUserLists(Principal principal) {
		List<UserList> userLists = userListService.findAll(principal.getName());
		if (userLists.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(userLists, HttpStatus.OK);
		}
    }

    @GetMapping("lists/{listId}")
    public ResponseEntity<UserList> getUserList(
            @PathVariable("listId") int listId,
            Principal principal) {
        UserList userList = userListService.find(principal.getName(), listId);
        if (userList != null) {
            return new ResponseEntity<>(userList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("lists")
    public ResponseEntity<UserList> createUserList(
            @RequestBody UserList userList,
            Principal principal) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();

            User user = authService.getUserByUsername(username);

            if (user != null) {
                userList.setUser(user);
                UserList createdUserList = userListService.create(username, userList);
                if (createdUserList != null) {
                    return new ResponseEntity<>(createdUserList, HttpStatus.CREATED);
                }
            }
        }
        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }

    @PutMapping("lists/{listId}")
    public ResponseEntity<UserList> updateUserList(
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

    @DeleteMapping("lists/{listId}")
    public ResponseEntity<Void> deleteUserList(
            @PathVariable("listId") int listId,
            Principal principal) {
        ResponseEntity<Void> response = userListService.delete(principal.getName(), listId);
        
        if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
            return response;
        } else if (response.getStatusCode() == HttpStatus.FORBIDDEN) {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        } else if (response.getStatusCode() == HttpStatus.NOT_FOUND) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    
    @PostMapping("lists/{listId}/stories/{storyId}")
    public ResponseEntity<?> addStoryToList(
            @PathVariable("listId") int listId,
            @PathVariable("storyId") int storyId,
            Principal principal) {
        UserList updatedUserList = userListService.addStoryToUserList(listId, storyId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }

    @DeleteMapping("lists/{listId}/stories/{storyId}")
    public ResponseEntity<?> removeStoryFromList(
            @PathVariable("listId") int listId,
            @PathVariable("storyId") int storyId,
            Principal principal) {
        UserList updatedUserList = userListService.removeStoryFromUserList(listId, storyId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping("lists/{listId}/poems/{poemId}")
    public ResponseEntity<?> addPoemToList(
            @PathVariable("listId") int listId,
            @PathVariable("poemId") int poemId,
            Principal principal) {
        UserList updatedUserList = userListService.addPoemToUserList(listId, poemId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }

    @DeleteMapping("lists/{listId}/poems/{poemId}")
    public ResponseEntity<?> removePoemFromList(
            @PathVariable("listId") int listId,
            @PathVariable("poemId") int poemId,
            Principal principal) {
        UserList updatedUserList = userListService.removePoemFromUserList(listId, poemId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping("lists/{listId}/miscellaneas/{miscellaneaId}")
    public ResponseEntity<?> addMiscellaneaToList(
            @PathVariable("listId") int listId,
            @PathVariable("miscellaneaId") int miscellaneaId,
            Principal principal) {
        UserList updatedUserList = userListService.addMiscellaneaToUserList(listId, miscellaneaId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }

    @DeleteMapping("lists/{listId}/miscellaneas/{miscellaneaId}")
    public ResponseEntity<?> removeMiscellaneaFromList(
            @PathVariable("listId") int listId,
            @PathVariable("miscellaneaId") int miscellaneaId,
            Principal principal) {
        UserList updatedUserList = userListService.removeMiscellaneaFromUserList(listId, miscellaneaId, principal.getName());

        if (updatedUserList != null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>("Unauthorized access: You cannot modify this user's list.", HttpStatus.FORBIDDEN);
        }
    }
    
    @PostMapping("lists/{listId}/removeItems")
    public ResponseEntity<UserList> removeItemsFromUserList(
        @PathVariable int listId,
        @RequestBody Map<String, List<Integer>> itemsToRemove,
        Principal principal
    ) {
        String username = principal.getName();
        UserList updatedUserList = userListService.removeItemsFromUserList(listId, itemsToRemove, username);

        if (updatedUserList != null) {
            return new ResponseEntity<>(updatedUserList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PostMapping("lists/addItems")
    public ResponseEntity<?> addItemsToUserList(
            @RequestParam("objectId") int objectId,
            @RequestParam("objectType") String objectType,
            @RequestParam("userListIds") List<Integer> userListIds,
            Principal principal) {

        String username = principal.getName();

        try {
            List<UserList> updatedUserLists = userListService.addObjectToUserLists(objectId, objectType, userListIds, username);
            return ResponseEntity.ok(updatedUserLists);
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (AccessDeniedException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("User does not have permission to update the user list.");
        }
    }

}
