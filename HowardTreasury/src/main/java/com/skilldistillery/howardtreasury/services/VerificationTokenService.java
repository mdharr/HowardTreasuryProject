package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.entities.VerificationToken;

public interface VerificationTokenService {

	public String createVerificationToken(User user);
	public VerificationToken getVerificationToken(String token);
	
}
