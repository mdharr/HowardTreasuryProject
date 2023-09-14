package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.UserList;
import com.skilldistillery.howardtreasury.repositories.UserListRepository;

@Service
public class UserListServiceImpl implements UserListService {

	@Autowired
	private UserListRepository userListRepo;

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
	    	// Update properties of existingUserList with values from updatedUserList.
	    	existingUserList.setName(userList.getName());
	    	// Save the updated UserList.
	    	return userListRepo.save(existingUserList);
	    }
	    return null;
	}

	@Override
	public void delete(String username, int userListId) {
	    Optional<UserList> userListOpt = userListRepo.findById(userListId);
	    
	    if (userListOpt.isPresent()) {
	    	
	    	UserList userList = userListOpt.get();
	    	
	    	userListRepo.delete(userList);
	    	
	    }
	    
	}

}
