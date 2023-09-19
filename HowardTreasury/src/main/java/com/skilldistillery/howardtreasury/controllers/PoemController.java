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

import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.services.PoemService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class PoemController {

	@Autowired
	private PoemService poemService;
	
	@GetMapping("collections/{cid}/poems")
  public ResponseEntity<List<Poem>> getAllPoemsByCollection(@PathVariable("cid") int collectionId) {
      List<Poem> poems = poemService.findByCollectionId(collectionId);
      
      if (poems.isEmpty()) {
      	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
      }
      else {
      	return new ResponseEntity<>(poems, HttpStatus.OK);
      }
		
  }
	
	@GetMapping("poems")
	public ResponseEntity<List<Poem>> getAllPoems() {
		List<Poem> poems = poemService.findAll();
		
		if(poems.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(poems, HttpStatus.OK);
		}
	}
	
	@GetMapping("poems/{pid}")
	public ResponseEntity<Poem> getPoemById(@PathVariable("pid") int poemId) {
		Poem poem = poemService.find(poemId);
		
		if (poem != null) {
			return new ResponseEntity<>(poem, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("poems")
	public ResponseEntity<Poem> createPoem(@RequestBody Poem poem) {
		
		try {
			Poem createdPoem = poemService.create(poem);
			URI location = ServletUriComponentsBuilder.fromCurrentRequest()
					.path("/{id}")
					.buildAndExpand(createdPoem.getId())
					.toUri();
			return ResponseEntity.created(location).body(createdPoem);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
}
