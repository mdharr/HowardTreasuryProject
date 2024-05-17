package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String fromEmail;

	@Value("${spring.mail.password}")
	private String password;

	@Override
	public void sendVerificationEmail(String to, String subject, String emailBody) {

	    SimpleMailMessage message = new SimpleMailMessage();
	    message.setFrom(fromEmail);
	    message.setTo(to);
	    message.setSubject(subject);
	    message.setText(emailBody);
	    mailSender.send(message);
	}


}
