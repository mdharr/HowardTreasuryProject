package com.skilldistillery.howardtreasury.services;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

	private JavaMailSender mailSender;

    @Override
    public void sendVerificationEmail(String to, String subject, String emailBody) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("noreply@yourdomain.com");
        message.setTo(to);
        message.setSubject(subject);
        message.setText(emailBody);
        mailSender.send(message);
    }

}
