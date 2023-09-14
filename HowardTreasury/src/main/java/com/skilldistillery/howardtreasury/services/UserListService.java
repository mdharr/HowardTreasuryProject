package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.UserList;

public interface UserListService {

	public List<UserList> findAll(String username);
	
	public UserList find(String username, int userListId);
	
	public UserList create(String username, UserList userList);
	
	public UserList update(String username, int userListId, UserList userList);
	
	public void delete(String username, int userListId);

	void addStoryToList(int userListId, Story story, String username);

	void removeStoryFromList(int userListId, int storyId, String username);
	
}
