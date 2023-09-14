package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Story;

public interface StoryRepository extends JpaRepository<Story, Integer> {

	List<Story> findByCollections_Id(int collectionId);
}
