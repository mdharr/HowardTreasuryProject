package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.StoryQuote;
import com.skilldistillery.howardtreasury.services.StoryQuoteService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class StoryQuoteController {

	@Autowired
	private StoryQuoteService storyQuoteService;
	
	@GetMapping("quotes")
	public ResponseEntity<List<StoryQuote>> index() {
		List<StoryQuote> quotes = storyQuoteService.index();
		if (quotes.size() > 0) {
			return new ResponseEntity<>(quotes, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
