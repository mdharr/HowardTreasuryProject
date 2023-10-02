package com.skilldistillery.howardtreasury.controllers;

import java.net.URI;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.skilldistillery.howardtreasury.dtos.CollectionDetailsDTO;
import com.skilldistillery.howardtreasury.dtos.CollectionWithStoriesDTO;
import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;
import com.skilldistillery.howardtreasury.services.CollectionService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class CollectionController {

	@Autowired
	private CollectionService collectionService;
	
	@Autowired
	private PoemRepository poemRepo;
	
	@GetMapping("collections")
	public ResponseEntity<List<Collection>> getAllCollections() {
		List<Collection> collections = collectionService.findAll();
		if (collections.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(collections, HttpStatus.OK);
		}
	}
	
	@GetMapping("collections/{cid}")
	public ResponseEntity<Collection> getCollectionById(@PathVariable("cid") int collectionId) {
		Collection collection = collectionService.find(collectionId);
		if (collection != null) {
			return new ResponseEntity<>(collection, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
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
	
//	@PostMapping("collections")
//	public ResponseEntity<Collection> create(@RequestBody Collection collection) {
//		Collection createdCollection = collectionService.create(collection);
//	    if (createdCollection != null) {
//	        return new ResponseEntity<>(createdCollection, HttpStatus.CREATED);
//	    } else {
//	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//	    }
//	}
	
	@PutMapping("collections/{cid}")
	public ResponseEntity<Collection> updateCollection(@RequestBody Collection collection, @PathVariable("cid") int collectionId) {
		
	    try {
	        Collection updatedCollection = collectionService.update(collectionId, collection);
	        return ResponseEntity.ok(updatedCollection);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	    
	}
	
//	@PostMapping("collections")
//	public Collection createCollection(HttpServletRequest req, HttpServletResponse res, @RequestBody Collection collection) {
//		
//		try {
//			collectionService.create(collection);
//			res.setStatus(201);
//			StringBuffer url = req.getRequestURL();
//			url.append("/").append(collection.getId());
//			res.setHeader("Location", url.toString());		
//		} catch (Exception e) {
//			e.printStackTrace();
//			res.setStatus(400);
//			collection = null;
//		}
//		
//		return collection;
//	}
	
	@DeleteMapping("collections/{cid}")
	public ResponseEntity<String> deleteCollection(@PathVariable("cid") int collectionId) {
		
		try {
			collectionService.delete(collectionId);
			return ResponseEntity.ok("Collection deleted successfully");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Collection not found");
		}
	}
	
	// get collection details using data transfer object
    @GetMapping("collections/{cid}/details")
    public ResponseEntity<CollectionDetailsDTO> getCollectionDetails(@PathVariable("cid") int collectionId) {
        CollectionDetailsDTO collectionDetailsDTO = collectionService.findCollectionDetails(collectionId);

        if (collectionDetailsDTO != null) {
            return new ResponseEntity<>(collectionDetailsDTO, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
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
    
    @GetMapping("collections/{cid}/pages")
    public ResponseEntity<CollectionWithStoriesDTO> getCollectionWithStoriesById(@PathVariable("cid") int collectionId) {
        CollectionWithStoriesDTO collectionDTO = collectionService.findCollectionWithStories(collectionId);
        if (collectionDTO != null) {
            return new ResponseEntity<>(collectionDTO, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @GetMapping("poems/{pid}/collection")
    public ResponseEntity<List<Collection>> getCollectionsByPoem(@PathVariable("pid") int poemId) {
    	Optional<Poem> poemOpt = poemRepo.findById(poemId);
    	if(poemOpt.isPresent()) {
    		Poem poem = poemOpt.get();
    		List<Collection> collections = collectionService.getByPoemId(poem.getId());
    		return new ResponseEntity<>(collections, HttpStatus.OK);
    	}
    	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
	
}
