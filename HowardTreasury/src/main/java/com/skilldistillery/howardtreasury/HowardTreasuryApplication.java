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
        if (Files.exists(Paths.get(".env"))) {
            Dotenv dotenv = Dotenv.configure().load();
            System.setProperty("MAIL_USERNAME", dotenv.get("MAIL_USERNAME"));
            System.setProperty("MAIL_PASSWORD", dotenv.get("MAIL_PASSWORD"));
            System.setProperty("OPENAI_API_KEY", dotenv.get("OPENAI_API_KEY"));
        }
        
		SpringApplication.run(HowardTreasuryApplication.class, args);
	}
	
	@Bean
	public PasswordEncoder configurePasswordEncoder() {
	   return new BCryptPasswordEncoder();
	}

}
