package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	private ChatRoomRepository chatRoomRepo;
	
	@Override
    public List<ChatRoom> findAllChatRooms() {
        return chatRoomRepo.findAll();
    }

	@Override
	public ChatRoom find(int id) {
		Optional<ChatRoom> chatRoomOpt = chatRoomRepo.findById(id);
		if(chatRoomOpt.isPresent()) {
			ChatRoom chatRoom = chatRoomOpt.get();
			return chatRoom;
		}
		return null;
	}
}
