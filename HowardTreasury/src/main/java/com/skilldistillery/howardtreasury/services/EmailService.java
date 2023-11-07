package com.skilldistillery.howardtreasury.services;

public interface EmailService {
	
    void sendVerificationEmail(String to, String subject, String emailBody);
    
}
