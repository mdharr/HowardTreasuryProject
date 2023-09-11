package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.UserList;

public interface UserListRepository extends JpaRepository<UserList, Integer> {

}
