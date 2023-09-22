package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Miscellanea;

public interface MiscellaneaRepository extends JpaRepository<Miscellanea, Integer> {

	List<Miscellanea> findByCollections_Id(int collectionId);
	
	List<Miscellanea> findByTitleContaining(String query);
	
}
