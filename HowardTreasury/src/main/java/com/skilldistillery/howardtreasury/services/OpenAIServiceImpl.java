package com.skilldistillery.howardtreasury.services;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.core.publisher.Mono;

@Service
public class OpenAIServiceImpl implements OpenAIService {

	private final WebClient webClient;

    @Value("${OPENAI_API_KEY}")
    private String openAIApiKey;

    public OpenAIServiceImpl(WebClient webClient) {
        this.webClient = webClient;
    }

    @Override
    public Mono<String> getAdventureResponse(String userMessage) {
        String model = "gpt-4o";
        int maxTokens = 300;
        double temperature = 0.7;

        Map<String, Object> systemMessage = new HashMap<>();
        systemMessage.put("role", "system");
        systemMessage.put("content", "You are a dungeon master guiding users on adventures inspired by Robert E. Howard. Speak in the style of Robert E. Howard, using rich, descriptive language and a tone that captures the essence of his heroic fantasy stories. Always finish each response by asking the user: 'What would you like to do?' If the user dies or completes the adventure, inform them that they must start a new adventure and cannot continue the current one.");

        Map<String, Object> userMessageMap = new HashMap<>();
        userMessageMap.put("role", "user");
        userMessageMap.put("content", userMessage);

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", model);
        requestBody.put("messages", Arrays.asList(systemMessage, userMessageMap));
        requestBody.put("max_tokens", maxTokens);
        requestBody.put("temperature", temperature);

        return webClient.post()
            .uri("/chat/completions")
            .header("Authorization", "Bearer " + openAIApiKey)
            .contentType(org.springframework.http.MediaType.APPLICATION_JSON)
            .bodyValue(requestBody)
            .retrieve()
            .bodyToMono(String.class);
    }

}
