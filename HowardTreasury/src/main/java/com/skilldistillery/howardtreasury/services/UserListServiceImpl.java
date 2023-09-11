package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.UserListRepository;

@Service
public class UserListServiceImpl implements UserListService {

	@Autowired
	private UserListRepository userListRepo;
}
