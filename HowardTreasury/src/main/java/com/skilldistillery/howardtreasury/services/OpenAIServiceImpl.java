package com.skilldistillery.howardtreasury.services;

import java.util.HashMap;
import java.util.List;
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
    public Mono<Map<String, String>> getAdventureResponse(List<Map<String, String>> messages) {
        String model = "gpt-4o";
        int maxTokens = 300;
        double temperature = 0.7;
        String[] stopSequences = {"What would you like to do?"};

        if (messages.isEmpty() || !messages.get(0).get("role").equals("system")) {
            Map<String, String> systemMessage = new HashMap<>();
            systemMessage.put("role", "system");
            systemMessage.put("content", "You are a dungeon master guiding users on adventures inspired by Robert E. Howard. Speak in the style of Robert E. Howard, using rich, descriptive language and a tone that captures the essence of his heroic fantasy stories. Always finish each response by asking the user: 'What would you like to do?' If the user dies or completes the adventure, inform them that they must start a new adventure and cannot continue the current one.");
            messages.add(0, systemMessage);
        }

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", model);
        requestBody.put("messages", messages);
        requestBody.put("max_tokens", maxTokens);
        requestBody.put("temperature", temperature);
        requestBody.put("stop", stopSequences);

        return webClient.post()
            .uri("/chat/completions")
            .header("Authorization", "Bearer " + openAIApiKey)
            .contentType(org.springframework.http.MediaType.APPLICATION_JSON)
            .bodyValue(requestBody)
            .retrieve()
            .bodyToMono(Map.class)
            .map(response -> {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> choices = (List<Map<String, Object>>) response.get("choices");
                @SuppressWarnings("unchecked")
				Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
                String content = (String) message.get("content");
                if (!content.endsWith("What would you like to do?")) {
                    content += " What would you like to do?";
                }
                Map<String, String> result = new HashMap<>();
                result.put("content", content);
                return result;
            });
    }
}
