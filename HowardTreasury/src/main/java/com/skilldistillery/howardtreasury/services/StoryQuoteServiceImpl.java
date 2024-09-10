package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.StoryQuote;
import com.skilldistillery.howardtreasury.repositories.StoryQuoteRepository;

@Service
public class StoryQuoteServiceImpl implements StoryQuoteService {

	@Autowired
	private StoryQuoteRepository storyQuoteRepo;
	
	public List<StoryQuote> index() {
		return storyQuoteRepo.findAll();
	}
	
	public StoryQuote find(int storyQuoteId) {
		Optional<StoryQuote> storyQuoteOpt = storyQuoteRepo.findById(storyQuoteId);
		
		if (storyQuoteOpt.isPresent()) {
			StoryQuote storyQuote = storyQuoteOpt.get();
			return storyQuote;
		}
		return null;
	}
	
	public List<StoryQuote> findByStory(Story story) {
		List<StoryQuote> storyQuotes = storyQuoteRepo.findByStory(story);
		if (storyQuotes.size() > 0) {
			return storyQuotes;
		}
		return null;
	}
}
