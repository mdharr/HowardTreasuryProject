package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Poem;

public interface PoemRepository extends JpaRepository<Poem, Integer> {

	List<Poem> findByCollections_Id(int collectionId);
	
	List<Poem> findAllByOrderByIdAsc();
}
