package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Story;

public interface StoryService {

	public List<Story> findByCollectionId(int collectionId);
	
	public List<Story> findAll();
	
	public Story find(int storyId);
	
	public Story create(Story story);
	
}
