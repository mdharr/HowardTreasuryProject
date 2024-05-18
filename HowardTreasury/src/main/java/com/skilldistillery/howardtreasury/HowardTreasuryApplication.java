package com.skilldistillery.howardtreasury;

import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import io.github.cdimascio.dotenv.Dotenv;

@SpringBootApplication
public class HowardTreasuryApplication {

	public static void main(String[] args) {
        Dotenv dotenv;
        if (Files.exists(Paths.get("/home/ec2-user/.env"))) {
            dotenv = Dotenv.configure().directory("/home/ec2-user").load();
        } else {
            dotenv = Dotenv.configure().load();
        }
        System.setProperty("MAIL_USERNAME", dotenv.get("MAIL_USERNAME"));
        System.setProperty("MAIL_PASSWORD", dotenv.get("MAIL_PASSWORD"));
		SpringApplication.run(HowardTreasuryApplication.class, args);
	}
	
	@Bean
	public PasswordEncoder configurePasswordEncoder() {
	   return new BCryptPasswordEncoder();
	}

}
