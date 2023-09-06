package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.ChatRoom;

public interface ChatRoomRepository extends JpaRepository<ChatRoom, Integer> {

}
