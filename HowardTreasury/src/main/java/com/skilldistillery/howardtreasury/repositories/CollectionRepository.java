package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Collection;

public interface CollectionRepository extends JpaRepository<Collection, Integer> {

	Collection findByTitle(String collectionTitle);

	List<Collection> findByTitleContaining(String query);
	
}
