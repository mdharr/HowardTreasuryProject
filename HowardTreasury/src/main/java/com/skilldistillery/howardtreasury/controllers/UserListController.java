package com.skilldistillery.howardtreasury.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.services.UserListService;

@RestController
@CrossOrigin({"*", "http://localhost"})
public class UserListController {

	@Autowired
	private UserListService userListService;
	
}
