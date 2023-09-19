package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.repositories.PersonRepository;

@Service
public class PersonServiceImpl implements PersonService {

	@Autowired
	private PersonRepository personRepo;

	@Override
	public List<Person> findAll() {
		return personRepo.findAll();
	}

	@Override
	public Person find(int personId) {
		Optional<Person> personOpt = personRepo.findById(personId);
		if(personOpt.isPresent()) {
			Person person = personOpt.get();
			return person;
		}
		return null;
	}

	@Override
	public Person create(Person person) {
		
		Person newPerson = new Person();
		
		newPerson.setName(person.getName());
		
		if(person.getCollections() != null) {
			newPerson.setCollections(person.getCollections());
		}
		
		return personRepo.save(newPerson);
	}
	
	@Override
	public List<Person> findByCollectionId(int collectionId) {
		return personRepo.findByCollections_Id(collectionId);
	}
}

