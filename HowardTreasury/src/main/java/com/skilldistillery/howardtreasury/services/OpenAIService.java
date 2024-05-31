package com.skilldistillery.howardtreasury.services;

import reactor.core.publisher.Mono;

public interface OpenAIService {

	Mono<String> getAdventureResponse(String userMessage);
}
