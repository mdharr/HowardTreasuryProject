package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.ChatMessageRepository;

@Service
public class ChatMessageServiceImpl {

	@Autowired
	private ChatMessageRepository chatMessageRepo;
}
