package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.UserDTO;
import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.ChatRoomRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	
    @Autowired
    private ChatRoomRepository chatRoomRepository;

	@Override
	public UserDTO mapUserToDTO(User user) {
    	UserDTO dto = new UserDTO();
    	dto.setId(user.getId());
    	dto.setUsername(user.getUsername());
    	dto.setEnabled(user.getEnabled());
    	dto.setRole(user.getRole());
    	dto.setEmail(user.getEmail());
    	dto.setImageUrl(user.getImageUrl());
        return dto;
    }
}
