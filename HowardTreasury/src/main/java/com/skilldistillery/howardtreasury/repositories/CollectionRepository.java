package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Collection;

public interface CollectionRepository extends JpaRepository<Collection, Integer> {

	Collection findByTitle(String collectionTitle);
}
