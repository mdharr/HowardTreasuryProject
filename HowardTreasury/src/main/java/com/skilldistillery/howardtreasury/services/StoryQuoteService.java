package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.StoryQuote;

public interface StoryQuoteService {
	
	public List<StoryQuote> index();
	public StoryQuote find(int storyQuoteId);
	public List<StoryQuote> findByStory(Story story);
}
