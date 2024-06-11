package com.skilldistillery.howardtreasury.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.UserDTO;
import com.skilldistillery.howardtreasury.entities.ChatRoom;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.WeirdTales;
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
	
	@Override
	public User find(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			return user;
		}
		return null;
	}
}
