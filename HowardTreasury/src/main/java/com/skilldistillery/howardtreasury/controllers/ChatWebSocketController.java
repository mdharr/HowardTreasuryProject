package com.skilldistillery.howardtreasury.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.skilldistillery.howardtreasury.dtos.ChatMessageDTO;
import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
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
        // Save the message
        ChatMessage savedMessage = chatMessageService.save(chatMessage);

        // Convert saved entity to DTO
        return chatMessageService.convertToDTO(savedMessage);
    }
    
}

