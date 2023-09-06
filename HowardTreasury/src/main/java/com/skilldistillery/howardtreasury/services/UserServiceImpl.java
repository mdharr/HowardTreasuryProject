package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class UserServiceImpl {

	@Autowired
	private UserRepository userRepo;
}
