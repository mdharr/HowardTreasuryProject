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

import com.skilldistillery.howardtreasury.entities.CollectionImage;
import com.skilldistillery.howardtreasury.services.CollectionImageService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class CollectionImageController {

	@Autowired
	private CollectionImageService collectionImageService;
	
	@GetMapping("collections/{cid}/collection-images")
	public ResponseEntity<List<CollectionImage>> getCollectionImagesByCollection(@PathVariable("cid") int collectionId) {
		List<CollectionImage> collectionImages = collectionImageService.findByCollectionId(collectionId);
		if (collectionImages.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(collectionImages, HttpStatus.OK);
		}
	}
	
	@GetMapping("collection-images")
	public ResponseEntity<List<CollectionImage>> getAllCollectionImages() {
		List<CollectionImage> collectionImages = collectionImageService.findAll();
		if (collectionImages.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(collectionImages, HttpStatus.OK);
		}
	}
	
	@GetMapping("collection-images/{cid}")
	public ResponseEntity<CollectionImage> getCollectionImageById(@PathVariable("cid") int collectionImageId) {
		CollectionImage collectionImage = collectionImageService.find(collectionImageId);
		if (collectionImage != null) {
			return new ResponseEntity<>(collectionImage, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("collection-images")
	public ResponseEntity<CollectionImage> createCollectionImage(@RequestBody CollectionImage collectionImage) {
		
	    try {
	    	CollectionImage createdCollectionImage = collectionImageService.create(collectionImage);
	        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
	            .path("/{id}")
	            .buildAndExpand(createdCollectionImage.getId())
	            .toUri();
	        return ResponseEntity.created(location).body(createdCollectionImage);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	    }
	}
	
}
