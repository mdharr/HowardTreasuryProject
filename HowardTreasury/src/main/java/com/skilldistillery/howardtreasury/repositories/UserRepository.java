package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);
	
}
