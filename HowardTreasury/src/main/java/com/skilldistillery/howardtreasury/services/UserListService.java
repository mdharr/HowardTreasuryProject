package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.skilldistillery.howardtreasury.entities.UserList;

public interface UserListService {

	public List<UserList> findAll(String username);
	
	public UserList find(String username, int userListId);
	
	public UserList create(String username, UserList userList);
	
	public UserList update(String username, int userListId, UserList userList);
	
	public ResponseEntity<Void> delete(String username, int userListId);

	UserList addStoryToUserList(int listId, int storyId, String username);

	UserList removeStoryFromUserList(int listId, int storyId, String username);

	UserList addPoemToUserList(int listId, int poemId, String username);

	UserList removePoemFromUserList(int listId, int poemId, String username);

	UserList addMiscellaneaToUserList(int listId, int miscellaneaId, String username);

	UserList removeMiscellaneaFromUserList(int listId, int miscellaneaId, String username);

}
