package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;

@Service
public class ChatRoomServiceImpl {

	@Autowired
	private ChatRoomRepository chatRoomRepo;
}
