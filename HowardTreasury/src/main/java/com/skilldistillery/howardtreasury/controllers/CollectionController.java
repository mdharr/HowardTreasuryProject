package com.skilldistillery.howardtreasury.controllers;

import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.services.CollectionService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class CollectionController {

	@Autowired
	private CollectionService collectionService;
	
	@GetMapping("collections")
	public List<Collection> getAllCollections() {
		return collectionService.findAll();
	}
	
	// collection by id
	@GetMapping("collections/{cid}")
	public Collection getCollectionById(@PathVariable("cid") int collectionId) {
		return collectionService.find(collectionId);
	}
	
	@PostMapping("collections")
	public ResponseEntity<Collection> createCollection(@RequestBody Collection collection) {
		
	    try {
	        Collection createdCollection = collectionService.create(collection);
	        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
	            .path("/{id}")
	            .buildAndExpand(createdCollection.getId())
	            .toUri();
	        return ResponseEntity.created(location).body(createdCollection);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	    }
	}
	
	@DeleteMapping("collections/{cid}")
	public ResponseEntity<String> deleteCollection(@PathVariable("cid") int collectionId) {
		
		try {
			collectionService.delete(collectionId);
			return ResponseEntity.ok("Collection deleted successfully");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Collection not found");
		}
	}
	
	// collection by title
//	@GetMapping("collections/{ct}")
//	public Collection getCollectionByTitle(@PathVariable("ct") String collectionTitle, HttpServletResponse res) {
//		String originalTitle = collectionTitle.replace("-", " ");
//		if(collectionService.getByTitle(collectionTitle) == null) {
//			res.setStatus(404);
//		}
//		return collectionService.getByTitle(originalTitle);
//	}
	
}
