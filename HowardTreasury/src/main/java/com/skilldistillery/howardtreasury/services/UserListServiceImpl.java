package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.repositories.MiscellaneaRepository;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;
import com.skilldistillery.howardtreasury.repositories.StoryRepository;
import com.skilldistillery.howardtreasury.repositories.UserListRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

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
	
	@Autowired
	private UserRepository userRepo;

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
	
	@Override
	public UserList removeItemsFromUserList(int listId, Map<String, List<Integer>> itemsToRemove, String username) {
	    // Fetch the UserList by its ID.
	    UserList userList = userListRepo.findById(listId).orElse(null);

	    // Ensure that the UserList exists and the user is the owner of the list.
	    if (userList != null && userList.getUser().getUsername().equals(username)) {
	        // Iterate over the map and remove items based on their type.
	        for (Map.Entry<String, List<Integer>> entry : itemsToRemove.entrySet()) {
	            String itemType = entry.getKey();
	            List<Integer> itemIds = entry.getValue();

	            switch (itemType) {
	                case "story":
	                    // Remove story items
	                    userList.getStories().removeIf(story -> itemIds.contains(story.getId()));
	                    break;
	                case "poem":
	                    // Remove poem items
	                    userList.getPoems().removeIf(poem -> itemIds.contains(poem.getId()));
	                    break;
	                case "miscellanea":
	                    // Remove miscellanea items
	                    userList.getMiscellaneas().removeIf(miscellanea -> itemIds.contains(miscellanea.getId()));
	                    break;
	                // Handle other item types if needed
	            }
	        }

	        return userListRepo.save(userList);
	    }
	    return null;
	}
	
	@Override
	public List<UserList> addObjectToUserLists(int objectId, String objectType, List<Integer> userListIds, String username) {
	    // Check if the provided 'username' matches the owner of the user lists.
	    User user = userRepo.findByUsername(username);
	    if (user == null) {
	        throw new EntityNotFoundException("User not found");
	    }
	    
	    List<UserList> userLists = userListRepo.findAllById(userListIds);

	    // Ensure that the user requesting the update owns the user lists.
	    for (UserList userList : userLists) {
	        if (!user.equals(userList.getUser())) {
	            throw new AccessDeniedException("User does not have permission to update the user list.");
	        }
	    }

	    if ("story".equals(objectType)) {
	        Optional<Story> storyOptional = storyRepo.findById(objectId);
	        if (storyOptional.isPresent()) {
	            Story story = storyOptional.get();

	            for (UserList userList : userLists) {
	                userList.getStories().add(story);
	            }

	            return userListRepo.saveAll(userLists);
	        }
	    } else if ("poem".equals(objectType)) {
	        Optional<Poem> poemOptional = poemRepo.findById(objectId);
	        if (poemOptional.isPresent()) {
	            Poem poem = poemOptional.get();

	            for (UserList userList : userLists) {
	                userList.getPoems().add(poem);
	            }

	            return userListRepo.saveAll(userLists);
	        }
	    } else if ("miscellanea".equals(objectType)) {
	        Optional<Miscellanea> miscellaneaOptional = miscellaneaRepo.findById(objectId);
	        if (miscellaneaOptional.isPresent()) {
	            Miscellanea miscellanea = miscellaneaOptional.get();

	            for (UserList userList : userLists) {
	                userList.getMiscellaneas().add(miscellanea);
	            }

	            return userListRepo.saveAll(userLists);
	        }
	    }

	    // Handle the case where the object type or object ID doesn't correspond to any of the expected entities.
	    throw new EntityNotFoundException("Object not found");
	}


	
}
