package com.skilldistillery.howardtreasury.controllers;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.services.PersonService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class PersonController {

	@Autowired
	private PersonService personService;
	
	@GetMapping("collections/{cid}/persons")
  public ResponseEntity<List<Person>> getAllPersonsByCollection(@PathVariable("cid") int collectionId) {
      List<Person> persons = personService.findByCollectionId(collectionId);
      
      if (persons.isEmpty()) {
      	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
      }
      else {
      	return new ResponseEntity<>(persons, HttpStatus.OK);
      }
		
  }
	
	@GetMapping("persons")
	public ResponseEntity<List<Person>> getAllPersons() {
		List<Person> persons = personService.findAll();
		
		if(persons.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(persons, HttpStatus.OK);
		}
	}
	
	@GetMapping("persons/{pid}")
	public ResponseEntity<Person> getPersonById(@PathVariable("pid") int personId) {
		Person person = personService.find(personId);
		
		if (person != null) {
			return new ResponseEntity<>(person, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("persons")
	public ResponseEntity<Person> createPerson(@RequestBody Person person) {
		
		try {
			Person createdPerson = personService.create(person);
			URI location = ServletUriComponentsBuilder.fromCurrentRequest()
					.path("/{id}")
					.buildAndExpand(createdPerson.getId())
					.toUri();
			return ResponseEntity.created(location).body(createdPerson);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
}
