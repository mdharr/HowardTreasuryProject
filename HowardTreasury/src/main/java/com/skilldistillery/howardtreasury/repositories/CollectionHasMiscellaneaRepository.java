package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.CollectionHasMiscellanea;

public interface CollectionHasMiscellaneaRepository extends JpaRepository<CollectionHasMiscellanea, Integer> {

	List<CollectionHasMiscellanea> findByCollectionId(int collectionId);
}
