package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.dtos.ChatMessageDTO;
import com.skilldistillery.howardtreasury.entities.ChatMessage;

public interface ChatMessageService {

	public ChatMessage save(ChatMessage chatMessage);
	public ChatMessageDTO convertToDTO(ChatMessage chatMessage);
	public List<ChatMessage> findMessagesByChatRoom(int roomId);
}
