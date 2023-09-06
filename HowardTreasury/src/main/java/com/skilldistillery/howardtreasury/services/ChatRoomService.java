package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;

public interface ChatRoomService {
	
	// Create a new chat room
    public ChatRoom createChatRoom(String name, String description, int ownerId);

    // Get a chat room by ID
    public ChatRoom getChatRoomById(int chatRoomId);

    // Get all chat rooms
    public List<ChatRoom> getAllChatRooms();

    // Join a user to a chat room
    public void joinChatRoom(int chatRoomId, int userId);

    // Leave a user from a chat room
    public void leaveChatRoom(int chatRoomId, int userId);

    // Get users in a chat room
    public List<User> getUsersInChatRoom(int chatRoomId);

    // Delete a chat room
    public void deleteChatRoom(int chatRoomId);

}
