package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.ChatMessage;

public interface ChatMessageService {

    // Send a message to a chat room
    public ChatMessage sendMessageToChatRoom(int chatRoomId, int senderUserId, String messageContent);

    // Get messages for a chat room
    public List<ChatMessage> getChatRoomMessages(int chatRoomId);

    // Delete a message
    public void deleteMessage(int messageId);

    // Edit a message
    public ChatMessage editMessage(int messageId, String newMessageContent);
}
