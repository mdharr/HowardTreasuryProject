package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.services.ChatMessageService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class ChatHistoryController {

    @Autowired
    private ChatMessageService chatMessageService;
    
    @GetMapping("chat-rooms/{roomId}/history")
    public ResponseEntity<List<ChatMessage>> getChatHistory(@PathVariable("roomId") int roomId) {
        List<ChatMessage> chatHistory = chatMessageService.findMessagesByChatRoom(roomId);
        return ResponseEntity.ok(chatHistory);
    }
}
