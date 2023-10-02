package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.dtos.CollectionDetailsDTO;
import com.skilldistillery.howardtreasury.dtos.CollectionWithStoriesDTO;
import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.CollectionHasStory;

public interface CollectionService {

	public List<Collection> findAll();
	
	public Collection find(int collectionId);
	
	public Collection create(Collection collection);
	
	public Collection update(int collectionId, Collection collection);
	
	public void delete(int collectionId);
	
	public Collection getByTitle(String collectionTitle);
	
	public CollectionWithStoriesDTO findCollectionWithStories(int collectionId);
	
	public List<CollectionHasStory> findStoriesByCollectionOrderByPageNumberAsc(Collection collection);

	CollectionDetailsDTO findCollectionDetails(int collectionId);
	
	public List<Collection> getByPoemId(int poemId);
	
	public List<Collection> getByMiscellaneaId(int miscellaneaId);

}
