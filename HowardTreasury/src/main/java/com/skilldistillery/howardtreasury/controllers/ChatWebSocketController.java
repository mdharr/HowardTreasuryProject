package com.skilldistillery.howardtreasury.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import com.skilldistillery.howardtreasury.dtos.ChatMessageDTO;
import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;
import com.skilldistillery.howardtreasury.services.ChatMessageService;

@Controller
public class ChatWebSocketController {
	
    @Autowired
    private ChatMessageService chatMessageService;
    
    @Autowired
    private ChatRoomRepository chatRoomRepo;
    
    @Autowired
    private UserRepository userRepo;
    
    
    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/publicChatRoom")
    public ChatMessageDTO sendMessage(@Payload ChatMessage chatMessage) {
        ChatMessage savedMessage = chatMessageService.save(chatMessage);

        return chatMessageService.convertToDTO(savedMessage);
    }
    
}

