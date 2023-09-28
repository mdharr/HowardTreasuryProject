package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.CollectionHasPoem;

public interface CollectionHasPoemRepository extends JpaRepository<CollectionHasPoem, Integer> {

	List<CollectionHasPoem> findByCollectionId(int collectionId);
}
