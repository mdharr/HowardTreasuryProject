package com.skilldistillery.howardtreasury.services;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.ResetPasswordToken;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.ResetPasswordTokenRepository;

@Service
public class ResetPasswordTokenServiceImpl implements ResetPasswordTokenService {
	
	@Autowired
	private ResetPasswordTokenRepository tokenRepo;

//	@Override
//	public String createPasswordResetToken(User user) {
//		ResetPasswordToken token = new ResetPasswordToken(user, UUID.randomUUID().toString());
//		tokenRepo.save(token);
//		return token.getToken();
//	}
	
    @Override
    public String createPasswordResetToken(User user) {
        // Before creating a new token, delete any existing tokens for the user
        ResetPasswordToken existingToken = tokenRepo.findByUser(user);
        if (existingToken != null) {
            tokenRepo.deleteByToken(existingToken.getToken());
        }
        ResetPasswordToken token = new ResetPasswordToken(user, UUID.randomUUID().toString());
        tokenRepo.save(token);
        return token.getToken();
    }

	@Override
	public ResetPasswordToken getResetPasswordToken(String token) {
		return tokenRepo.findByToken(token);
	}
	
    @Override
    public void deleteResetPasswordToken(String token) {
        tokenRepo.deleteByToken(token);
    }

}
