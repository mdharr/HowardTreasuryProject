package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Person;

public interface PersonService {

	public List<Person> findAll();
	
	public Person find(int personId);
	
	public Person create(Person person);

	List<Person> findByCollectionId(int collectionId);
}
