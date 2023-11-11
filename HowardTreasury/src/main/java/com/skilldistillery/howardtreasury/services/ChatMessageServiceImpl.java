package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.ChatMessageDTO;
import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.repositories.ChatMessageRepository;

@Service
public class ChatMessageServiceImpl implements ChatMessageService {

	@Autowired
	private ChatMessageRepository chatMessageRepo;
	
	@Override
    public ChatMessage save(ChatMessage chatMessage) {
        return chatMessageRepo.save(chatMessage);
    }
	
	@Override
    public ChatMessageDTO convertToDTO(ChatMessage chatMessage) {
        return new ChatMessageDTO(
                chatMessage.getId(),
                chatMessage.getMessageContent(),
                chatMessage.getCreatedAt(),
                chatMessage.getChatRoom().getId(),
                chatMessage.getUser().getId()
        );
    }

	@Override
	public List<ChatMessage> findMessagesByChatRoom(int roomId) {
		return chatMessageRepo.findByChatRoomIdOrderByCreatedAtDesc(roomId);
	}
}
