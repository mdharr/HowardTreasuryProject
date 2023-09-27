package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.CollectionHasStory;
import com.skilldistillery.howardtreasury.entities.Story;

public interface CollectionHasStoryRepository extends JpaRepository<CollectionHasStory, Integer>{
	
	List<CollectionHasStory> findByCollectionId(int collectionId);

	CollectionHasStory findByCollectionAndStory(Collection collection, Story story);
	
    @Query("SELECT chs FROM CollectionHasStory chs WHERE chs.collection = :collection ORDER BY chs.pageNumber ASC")
    List<CollectionHasStory> findStoriesByCollectionOrderByPageNumberAsc(Collection collection);
}
