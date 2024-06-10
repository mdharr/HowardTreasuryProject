package com.skilldistillery.howardtreasury.services;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.howardtreasury.entities.ResetPasswordToken;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.VerificationToken;
import com.skilldistillery.howardtreasury.repositories.ResetPasswordTokenRepository;

public class ResetPasswordTokenServiceImpl implements ResetPasswordTokenService {
	
	@Autowired
	private ResetPasswordTokenRepository tokenRepo;

	@Override
	public String createPasswordResetToken(User user) {
		ResetPasswordToken token = new ResetPasswordToken(user, UUID.randomUUID().toString());
		tokenRepo.save(token);
		return token.getToken();
	}

	@Override
	public ResetPasswordToken getResetPasswordToken(String token) {
		return tokenRepo.findByToken(token);
	}

}
