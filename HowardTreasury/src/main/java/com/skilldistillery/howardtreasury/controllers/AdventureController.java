package com.skilldistillery.howardtreasury.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.services.OpenAIService;

import reactor.core.publisher.Mono;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class AdventureController {

	@Autowired
	private OpenAIService openAIService;

    public AdventureController(OpenAIService openAIService) {
        this.openAIService = openAIService;
    }

    @PostMapping("adventure/response")
    public Mono<ResponseEntity<String>> getAdventureResponse(@RequestBody Map<String, String> request) {
        String userMessage = request.get("message");
        return openAIService.getAdventureResponse(userMessage)
            .map(ResponseEntity::ok)
            .defaultIfEmpty(ResponseEntity.status(500).body("Error retrieving response"));
    }
}
