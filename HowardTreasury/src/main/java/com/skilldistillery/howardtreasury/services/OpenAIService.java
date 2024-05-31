package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Map;

import reactor.core.publisher.Mono;

public interface OpenAIService {

//	Mono<String> getAdventureResponse(String userMessage);
	Mono<Map<String, String>> getAdventureResponse(List<Map<String, String>> messages);
}
