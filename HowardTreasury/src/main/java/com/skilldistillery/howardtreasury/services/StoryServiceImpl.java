package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.repositories.CollectionRepository;
import com.skilldistillery.howardtreasury.repositories.StoryRepository;

@Service
public class StoryServiceImpl implements StoryService {

	@Autowired
	private StoryRepository storyRepo;
	
	@Autowired
	private CollectionRepository collectionRepo;

	@Override
	public List<Story> findByCollectionId(int collectionId) {
		return storyRepo.findByCollections_Id(collectionId);
	}

	@Override
	public List<Story> findAll() {
		return storyRepo.findAll();
	}

}
