package com.skilldistillery.howardtreasury.services;

import java.util.List;

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
}
