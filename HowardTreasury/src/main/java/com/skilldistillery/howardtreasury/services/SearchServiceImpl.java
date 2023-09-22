package com.skilldistillery.howardtreasury.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.CollectionRepository;
import com.skilldistillery.howardtreasury.repositories.MiscellaneaRepository;
import com.skilldistillery.howardtreasury.repositories.PersonRepository;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;
import com.skilldistillery.howardtreasury.repositories.StoryRepository;

@Service
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private CollectionRepository collectionRepo;
	
	@Autowired
	private StoryRepository storyRepo;
	
	@Autowired
	private PoemRepository poemRepo;
	
	@Autowired
	private PersonRepository personRepo;
	
	@Autowired
	private MiscellaneaRepository miscellaneaRepo;

    @Override
    public List<Object> search(String query) {
        List<Object> results = new ArrayList<>();
        
        // Search for collections and add to results
        results.addAll(searchCollections(query));
        
        // Search for stories and add to results
        results.addAll(searchStories(query));
        
        // Search for poems and add to results
        results.addAll(searchPoems(query));
        
        // Search for persons and add to results
        results.addAll(searchPersons(query));
        
        // Search for miscellanea and add to results
        results.addAll(searchMiscellanea(query));
        
        return results;
    }
    
    private List<Object> searchCollections(String query) {
        return collectionRepo.findByTitleContaining(query).stream()
                .map(collection -> (Object) collection)
                .collect(Collectors.toList());
    }
    
    private List<Object> searchStories(String query) {
        return storyRepo.findByTitleContaining(query).stream()
                .map(story -> (Object) story)
                .collect(Collectors.toList());
    }
    
    private List<Object> searchPoems(String query) {
        return poemRepo.findByTitleContaining(query).stream()
                .map(poem -> (Object) poem)
                .collect(Collectors.toList());
    }
    
    private List<Object> searchPersons(String query) {
        return personRepo.findByNameContaining(query).stream()
                .map(person -> (Object) person)
                .collect(Collectors.toList());
    }
    
    private List<Object> searchMiscellanea(String query) {
        return miscellaneaRepo.findByTitleContaining(query).stream()
                .map(miscellanea -> (Object) miscellanea)
                .collect(Collectors.toList());
    }
}
