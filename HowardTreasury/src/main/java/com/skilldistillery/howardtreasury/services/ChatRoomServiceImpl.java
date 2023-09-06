package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class ChatRoomServiceImpl {
	
	@Autowired
	private UserRepository userRepo;

	@Autowired
	private ChatRoomRepository chatRoomRepo;
	
	// Create a new chat room
    public ChatRoom createChatRoom(String name, String description, int ownerId) {
        User owner = userRepo.findById(ownerId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        ChatRoom chatRoom = new ChatRoom();
        chatRoom.setName(name);
        chatRoom.setDescription(description);
        chatRoom.setOwner(owner);

        return chatRoomRepo.save(chatRoom);
    }

    // Get a chat room by ID
    public ChatRoom getChatRoomById(int chatRoomId) {
        return chatRoomRepo.findById(chatRoomId)
                .orElseThrow(() -> new IllegalArgumentException("Chat room not found"));
    }

    // Get all chat rooms
    public List<ChatRoom> getAllChatRooms() {
        return chatRoomRepo.findAll();
    }

    // Join a user to a chat room
    public void joinChatRoom(int chatRoomId, int userId) {
        ChatRoom chatRoom = getChatRoomById(chatRoomId);
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        chatRoom.addUser(user);
        chatRoomRepo.save(chatRoom);
    }

    // Leave a user from a chat room
    public void leaveChatRoom(int chatRoomId, int userId) {
        ChatRoom chatRoom = getChatRoomById(chatRoomId);
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        chatRoom.removeUser(user);
        chatRoomRepo.save(chatRoom);
    }

    // Get users in a chat room
    public List<User> getUsersInChatRoom(int chatRoomId) {
        ChatRoom chatRoom = getChatRoomById(chatRoomId);
        return chatRoom.getUsers();
    }

    // Delete a chat room
    public void deleteChatRoom(int chatRoomId) {
        chatRoomRepo.deleteById(chatRoomId);
    }
}
