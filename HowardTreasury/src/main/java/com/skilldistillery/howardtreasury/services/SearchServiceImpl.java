package com.skilldistillery.howardtreasury.services;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.repositories.BlogPostRepository;
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
	
	@Autowired
	private BlogPostRepository blogPostRepo;
	
    @Override
    public List<Map<String, Object>> search(String query) {
        List<Map<String, Object>> results = new ArrayList<>();
        
        results.addAll(searchCollections(query, "Collection"));
        
        results.addAll(searchStories(query, "Story"));
        
        results.addAll(searchPoems(query, "Poem"));
        
        results.addAll(searchPersons(query, "Person"));
        
        results.addAll(searchMiscellanea(query, "Miscellanea"));
        
        results.addAll(searchBlogPosts(query, "Post"));
        
        return results;
    }
    
    private List<Map<String, Object>> searchCollections(String query, String type) {
        return collectionRepo.findByTitleContaining(query).stream()
                .map(collection -> createResultMap(collection, type))
                .collect(Collectors.toList());
    }
    
    private List<Map<String, Object>> searchStories(String query, String type) {
    	return storyRepo.findByTitleContainingOrAlternateTitleContaining(query, query).stream()
    			.map(story -> createResultMap(story, type))
    			.collect(Collectors.toList());
    }
        
    private List<Map<String, Object>> searchPoems(String query, String type) {
        return poemRepo.findByTitleContaining(query).stream()
                .map(poem -> createResultMap(poem, type))
                .collect(Collectors.toList());
    }
    
    private List<Map<String, Object>> searchPersons(String query, String type) {
        return personRepo.findByNameContaining(query).stream()
                .map(person -> createResultMap(person, type))
                .collect(Collectors.toList());
    }
    
    private List<Map<String, Object>> searchMiscellanea(String query, String type) {
        return miscellaneaRepo.findByTitleContaining(query).stream()
                .map(miscellanea -> createResultMap(miscellanea, type))
                .collect(Collectors.toList());
    }
    
    private List<Map<String, Object>> searchBlogPosts(String query, String type) {
    	return blogPostRepo.findByTitleContainingOrContentContaining(query, query).stream()
    			.map(post -> createResultMap(post, type))
    			.collect(Collectors.toList());
    }

    private Map<String, Object> createResultMap(Object entity, String type) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("type", type);
        resultMap.put("data", entity);
        return resultMap;
    }
    
    private String fetchHtmlContent(String url) {
        try {
            Document doc = Jsoup.connect(url).get();
            return doc.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String parseHtmlAndExtractText(String htmlContent) {
        Document doc = Jsoup.parse(htmlContent);
        Elements elements = doc.select("p");

        StringBuilder extractedText = new StringBuilder();
        for (Element element : elements) {
            extractedText.append(element.text()).append("\n");
        }

        return extractedText.toString();
    }

}
