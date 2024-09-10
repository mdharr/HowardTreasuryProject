package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.StoryQuote;

public interface StoryQuoteRepository extends JpaRepository<StoryQuote, Integer> {

	List<StoryQuote> findByStory(Story story);
}
