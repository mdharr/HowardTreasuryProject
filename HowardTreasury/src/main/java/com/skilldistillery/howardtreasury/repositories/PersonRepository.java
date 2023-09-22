package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Person;

public interface PersonRepository extends JpaRepository<Person, Integer> {

	List<Person> findByCollections_Id(int collectionId);
	
	List<Person> findByNameContaining(String query);
}
