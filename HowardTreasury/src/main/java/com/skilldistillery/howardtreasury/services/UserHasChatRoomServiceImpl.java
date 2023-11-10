package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.UserHasChatRoomRepository;

@Service
public class UserHasChatRoomServiceImpl implements UserHasChatRoomService {

	@Autowired
	private UserHasChatRoomRepository userHasChatRoomRepo;
}
