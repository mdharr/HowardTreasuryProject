package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.services.PoemService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class PoemController {

	@Autowired
	private PoemService poemService;
	
	@GetMapping("collections/{cid}/poems")
    public List<Poem> getAllPoemsByCollection(@PathVariable("cid") int collectionId) {
        return poemService.findByCollectionId(collectionId);
    }
	
}
