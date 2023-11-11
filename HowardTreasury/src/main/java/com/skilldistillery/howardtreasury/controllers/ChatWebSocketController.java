package com.skilldistillery.howardtreasury.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;
import com.skilldistillery.howardtreasury.services.ChatMessageService;

@Controller
public class ChatWebSocketController {
	
    @Autowired
    private ChatMessageService chatMessageService;
    
    @Autowired
    private ChatRoomRepository chatRoomRepo;

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/publicChatRoom")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
        // Assume 'publicChatRoom' is the instance of the room you fetched from the database with ID 1
        Optional<ChatRoom> publicChatRoomOpt = chatRoomRepo.findById(1);// Fetch the public chat room instance by ID
        if(publicChatRoomOpt.isPresent()) {
        	ChatRoom publicChatRoom = publicChatRoomOpt.get();
        	chatMessage.setChatRoom(publicChatRoom); // Set the chat room to the message
        }
        return chatMessageService.save(chatMessage); // Save message when received
    }
    
//    @MessageMapping("/chat.sendMessage")
//    @SendTo("/topic/publicChatRoom")
//    public ChatMessage sendMessage(@Payload String messageContent) {
//        ChatMessage chatMessage = new ChatMessage();
//        chatMessage.setMessageContent(messageContent);
//        // ...set other necessary fields
//        return chatMessageService.save(chatMessage);
//    }

}

