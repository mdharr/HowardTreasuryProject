package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.ChatMessage;
import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.ChatMessageRepository;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class ChatMessageServiceImpl implements ChatMessageService {

	@Autowired
    private ChatMessageRepository chatMessageRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private ChatRoomRepository chatRoomRepo;

    // Send a message to a chat room
    public ChatMessage sendMessageToChatRoom(int chatRoomId, int senderUserId, String messageContent) {
        User sender = userRepo.findById(senderUserId)
                .orElseThrow(() -> new IllegalArgumentException("Sender not found"));

        ChatRoom chatRoom = chatRoomRepo.findById(chatRoomId)
                .orElseThrow(() -> new IllegalArgumentException("Chat room not found"));

        ChatMessage message = new ChatMessage();
        message.setMessageContent(messageContent);
        message.setUser(sender);
        message.setChatRoom(chatRoom);

        return chatMessageRepo.save(message);
    }

    // Get messages for a chat room
    public List<ChatMessage> getChatRoomMessages(int chatRoomId) {
        return chatMessageRepo.findByChatRoomIdOrderByCreatedAt(chatRoomId);
    }

    // Delete a message
    public void deleteMessage(int messageId) {
        chatMessageRepo.deleteById(messageId);
    }

    // Edit a message
    public ChatMessage editMessage(int messageId, String newMessageContent) {
        ChatMessage message = chatMessageRepo.findById(messageId)
                .orElseThrow(() -> new IllegalArgumentException("Message not found"));

        message.setMessageContent(newMessageContent);

        return chatMessageRepo.save(message);
    }
}
