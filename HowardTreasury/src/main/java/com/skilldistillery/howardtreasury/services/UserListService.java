package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.ListContent;
import com.skilldistillery.howardtreasury.entities.UserList;

public interface UserListService {

	public List<UserList> findAll(String username);
	
	public UserList find(String username, int userListId);
	
	public UserList create(String username, UserList userList);
	
	public UserList update(String username, int userListId, UserList userList);
	
	public void delete(String username, int userListId);

	void addListContent(int userListId, ListContent listContent, String username);

	void removeListContent(int userListId, int listContentId, String username);
}
