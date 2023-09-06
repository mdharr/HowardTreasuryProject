package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.services.ChatMessageService;

@RestController
@CrossOrigin({"*", "http://localhost"})
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageService chatMessageService;

    @Autowired
    public ChatController(SimpMessagingTemplate messagingTemplate, ChatMessageService chatMessageService) {
        this.messagingTemplate = messagingTemplate;
        this.chatMessageService = chatMessageService;
    }

    // Send a message to a chat room
    @MessageMapping("/chat/send")
    public void sendMessage(@Payload ChatMessage message, Principal principal) {
        String senderUsername = principal.getName();
        
        
//		TODO: START FROM HERE TOMORROW!!!

        // Set the sender's username
//        message.setSenderUsername(senderUsername);

        // Save the message
//        ChatMessage savedMessage = chatMessageService.sendMessageToChatRoom(
//            message.getChatRoom().getId(),
//            senderUsername,
//            message.getMessageContent()
//        );

        // Send the message to the WebSocket topic
//        messagingTemplate.convertAndSendToUser(
//            message.getChatRoom().getOwner().getUsername(),
//            "/queue/chat",
//            savedMessage
//        );
    }

    // Receive a message from the WebSocket and send it to the user
    @MessageMapping("/chat/receive")
    @SendToUser("/queue/chat")
    public ChatMessage receiveMessage(@Payload ChatMessage message) {
        // This method handles messages received from the WebSocket and sends them back to the user.
        // You can customize the logic as needed.

        // For example, if you want to process and filter messages, you can add your logic here.

        return message;
    }
}
