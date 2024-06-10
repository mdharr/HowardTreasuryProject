package com.skilldistillery.howardtreasury.services;

public interface EmailService {
	
    void sendVerificationEmail(String to, String subject, String emailBody);
    void sendResetPasswordEmail(String to, String subject, String emailBody);
    void sendHtmlEmail(String to, String subject, String htmlBody);

}
