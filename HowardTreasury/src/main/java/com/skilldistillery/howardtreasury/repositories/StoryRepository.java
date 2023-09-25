package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Story;

public interface StoryRepository extends JpaRepository<Story, Integer> {

	List<Story> findByCollections_Id(int collectionId);
	
	List<Story> findAllByOrderByIdAsc();

	List<Story> findByTitleContaining(String query);
	
	List<Story> findByAlternateTitleContaining(String query);
	
    List<Story> findByTitleContainingOrAlternateTitleContaining(String title, String alternateTitle);

}
