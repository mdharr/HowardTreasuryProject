package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Illustrator;

public interface IllustratorRepository extends JpaRepository<Illustrator, Integer> {
	
	List<Illustrator> findByCollections_Id(int collectionId);

}
