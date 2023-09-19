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

import com.skilldistillery.howardtreasury.entities.Illustrator;
import com.skilldistillery.howardtreasury.services.IllustratorService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class IllustratorController {

	@Autowired
	private IllustratorService illustratorService;
	
	@GetMapping("collections/{cid}/illustrators")
  public ResponseEntity<List<Illustrator>> getAllIllustratorsByCollection(@PathVariable("cid") int collectionId) {
      List<Illustrator> illustrators = illustratorService.findByCollectionId(collectionId);
      
      if (illustrators.isEmpty()) {
      	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
      }
      else {
      	return new ResponseEntity<>(illustrators, HttpStatus.OK);
      }
		
  }
	
	@GetMapping("illustrators")
	public ResponseEntity<List<Illustrator>> getAllIllustrators() {
		List<Illustrator> illustrators = illustratorService.findAll();
		
		if(illustrators.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(illustrators, HttpStatus.OK);
		}
	}
	
	@GetMapping("illustrators/{iid}")
	public ResponseEntity<Illustrator> getIllustratorById(@PathVariable("iid") int illustratorId) {
		Illustrator illustrator = illustratorService.find(illustratorId);
		
		if (illustrator != null) {
			return new ResponseEntity<>(illustrator, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("illustrators")
	public ResponseEntity<Illustrator> createIllustrator(@RequestBody Illustrator illustrator) {
		
		try {
			Illustrator createdIllustrator = illustratorService.create(illustrator);
			URI location = ServletUriComponentsBuilder.fromCurrentRequest()
					.path("/{id}")
					.buildAndExpand(createdIllustrator.getId())
					.toUri();
			return ResponseEntity.created(location).body(createdIllustrator);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
}
