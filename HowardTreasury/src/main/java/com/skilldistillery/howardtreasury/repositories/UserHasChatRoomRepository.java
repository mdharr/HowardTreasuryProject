package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.UserHasChatRoom;

public interface UserHasChatRoomRepository extends JpaRepository<UserHasChatRoom, Integer> {

}
