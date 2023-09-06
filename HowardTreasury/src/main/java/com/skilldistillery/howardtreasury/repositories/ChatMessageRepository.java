package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.ChatMessage;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Integer> {

}
