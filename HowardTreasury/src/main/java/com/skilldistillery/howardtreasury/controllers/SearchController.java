package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.services.SearchService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class SearchController {

	@Autowired
	private SearchService searchService;
	
    @GetMapping("search")
    public ResponseEntity<List<Object>> search(@RequestParam String query) {
        List<Object> results = searchService.search(query);
        
        // Check if results are empty and return an appropriate response
        if (results.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        
        return new ResponseEntity<>(results, HttpStatus.OK);
    }
}
