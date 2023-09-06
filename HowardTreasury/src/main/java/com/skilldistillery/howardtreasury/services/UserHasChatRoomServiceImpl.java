package com.skilldistillery.howardtreasury.services;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.UserHasChatRoom;
import com.skilldistillery.howardtreasury.repositories.UserHasChatRoomRepository;

public class UserHasChatRoomServiceImpl implements UserHasChatRoomService {

    @Autowired
    private UserHasChatRoomRepository userHasChatRoomRepo;

    public UserHasChatRoom createUserHasChatRoom(User user, ChatRoom chatRoom) {
        UserHasChatRoom userHasChatRoom = new UserHasChatRoom();
        userHasChatRoom.setUser(user);
        userHasChatRoom.setChatRoom(chatRoom);
        userHasChatRoom.setJoinedAt(LocalDateTime.now());
        userHasChatRoom.setLastActivity(LocalDateTime.now());
        userHasChatRoom.setNotificationPreferences("default");
        userHasChatRoom.setUnreadMessageCount(0);
        userHasChatRoom.setUserStatus("active");
        userHasChatRoom.setRole("user");
        
        return userHasChatRoomRepo.save(userHasChatRoom);
    }
}
