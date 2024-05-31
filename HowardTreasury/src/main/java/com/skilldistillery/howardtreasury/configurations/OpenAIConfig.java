package com.skilldistillery.howardtreasury.configurations;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class OpenAIConfig {
	
    @Bean
    public WebClient webClient(WebClient.Builder builder) {
        return builder.baseUrl("https://api.openai.com/v1").build();
    }
}
