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

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.services.StoryService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class StoryController {

	@Autowired
	private StoryService storyService;
	
	@GetMapping("collections/{cid}/stories")
    public ResponseEntity<List<Story>> getAllStoriesByCollection(@PathVariable("cid") int collectionId) {
        List<Story> stories = storyService.findByCollectionId(collectionId);
        
        if (stories.isEmpty()) {
        	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        else {
        	return new ResponseEntity<>(stories, HttpStatus.OK);
        }
		
    }
	
	@GetMapping("stories")
	public ResponseEntity<List<Story>> getAllStories() {
		List<Story> stories = storyService.findAll();
		
		if(stories.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(stories, HttpStatus.OK);
		}
	}
	
	@GetMapping("stories/{sid}")
	public ResponseEntity<Story> getStoryById(@PathVariable("sid") int storyId) {
		Story story = storyService.find(storyId);
		
		if (story != null) {
			return new ResponseEntity<>(story, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("stories")
	public ResponseEntity<Story> createStory(@RequestBody Story story) {
		
		try {
			Story createdStory = storyService.create(story);
			URI location = ServletUriComponentsBuilder.fromCurrentRequest()
					.path("/{id}")
					.buildAndExpand(createdStory.getId())
					.toUri();
			return ResponseEntity.created(location).body(createdStory);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
	
}
