package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.repositories.MiscellaneaRepository;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;
import com.skilldistillery.howardtreasury.repositories.StoryRepository;
import com.skilldistillery.howardtreasury.repositories.UserListRepository;

@Service
public class UserListServiceImpl implements UserListService {

	@Autowired
	private UserListRepository userListRepo;
	
	@Autowired
	private StoryRepository storyRepo;
	
	@Autowired
	private PoemRepository poemRepo;
	
	@Autowired
	private MiscellaneaRepository miscellaneaRepo;

	@Override
	public List<UserList> findAll(String username) {
		return userListRepo.findByUser_Username(username);
	}

	@Override
	public UserList find(String username, int userListId) {
	    return userListRepo.findById(userListId)
	            .orElseThrow(() -> new EntityNotFoundException("UserList not found with ID: " + userListId));
	}

	@Override
	public UserList create(String username, UserList userList) {
		return userListRepo.save(userList);
	}

	@Override
	public UserList update(String username, int userListId, UserList userList) {
	    Optional<UserList> existingUserListOpt = userListRepo.findById(userListId);

	    if (existingUserListOpt.isPresent()) {
	        UserList existingUserList = existingUserListOpt.get();

	        // Check if the user is the owner of the list.
	        if (existingUserList.getUser().getUsername().equals(username)) {
	            // Update properties of existingUserList with values from updatedUserList.
	            existingUserList.setName(userList.getName());
	            // Save the updated UserList.
	            return userListRepo.save(existingUserList);
	        } else {
	            return null; // Unauthorized access
	        }
	    }
	    return null; // List not found
	}

	@Override
	public ResponseEntity<Void> delete(String username, int userListId) {
	    Optional<UserList> userListOpt = userListRepo.findById(userListId);

	    if (userListOpt.isPresent()) {
	        UserList userList = userListOpt.get();

	        // Check if the user is the owner of the list.
	        if (userList.getUser().getUsername().equals(username)) {
	            userListRepo.delete(userList);
	            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // Resource deleted
	        } else {
	            return new ResponseEntity<>(HttpStatus.FORBIDDEN); // Unauthorized access
	        }
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND); // List not found
	    }
	}

	
	@Override
	public UserList addStoryToUserList(int listId, int storyId, String username) {
	    // Fetch the UserList and Story entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Story story = storyRepo.findById(storyId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && story != null && userList.getUser().getUsername().equals(username)) {
	        // Add the story to the user list.
	        userList.getStories().add(story);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fails.
	}

	@Override
	public UserList removeStoryFromUserList(int listId, int storyId, String username) {
	    // Fetch the UserList and Story entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Story story = storyRepo.findById(storyId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && story != null && userList.getUser().getUsername().equals(username)) {
	        // Remove the story from the user list.
	        userList.getStories().remove(story);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fails.
	}

	@Override
	public UserList addPoemToUserList(int listId, int poemId, String username) {
	    // Fetch the UserList and Poem entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Poem poem = poemRepo.findById(poemId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && poem != null && userList.getUser().getUsername().equals(username)) {
	        // Add the poem to the user list.
	        userList.getPoems().add(poem);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fails.
	}

	@Override
	public UserList removePoemFromUserList(int listId, int poemId, String username) {
	    // Fetch the UserList and Poem entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Poem poem = poemRepo.findById(poemId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && poem != null && userList.getUser().getUsername().equals(username)) {
	        // Remove the poem from the user list.
	        userList.getPoems().remove(poem);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fails.
	}
	
	@Override
	public UserList addMiscellaneaToUserList(int listId, int miscellaneaId, String username) {
	    // Fetch the UserList and Miscellanea entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Miscellanea miscellanea = miscellaneaRepo.findById(miscellaneaId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && miscellanea != null && userList.getUser().getUsername().equals(username)) {
	        // Add the miscellanea to the user list.
	        userList.getMiscellaneas().add(miscellanea);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fails.
	}

	@Override
	public UserList removeMiscellaneaFromUserList(int listId, int miscellaneaId, String username) {
	    // Fetch the UserList and Miscellanea entities by their IDs.
	    UserList userList = userListRepo.findById(listId).orElse(null);
	    Miscellanea miscellanea = miscellaneaRepo.findById(miscellaneaId).orElse(null);

	    // Ensure that both entities exist and the user is the owner of the list.
	    if (userList != null && miscellanea != null && userList.getUser().getUsername().equals(username)) {
	        // Remove the miscellanea from the user list.
	        userList.getMiscellaneas().remove(miscellanea);
	        return userListRepo.save(userList);
	    }
	    return null; // Handle the case when the operation fail
	}
	
}
