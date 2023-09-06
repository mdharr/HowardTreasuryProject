package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserHasChatRoom;

public interface UserHasChatRoomService {

	public UserHasChatRoom createUserHasChatRoom(User user, ChatRoom chatRoom);
}
