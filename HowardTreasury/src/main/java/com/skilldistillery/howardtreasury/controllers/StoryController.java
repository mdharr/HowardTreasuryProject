package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.services.StoryService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class StoryController {

	@Autowired
	private StoryService storyService;
	
	@GetMapping("collections/{cid}/stories")
    public List<Story> getAllStoriesByCollection(@PathVariable("cid") int collectionId) {
        return storyService.findByCollectionId(collectionId);
    }
}
