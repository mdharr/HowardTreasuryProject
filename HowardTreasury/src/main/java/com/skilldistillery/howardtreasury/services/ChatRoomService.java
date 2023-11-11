package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.ChatRoom;

public interface ChatRoomService {

	public List<ChatRoom> findAllChatRooms();
}
