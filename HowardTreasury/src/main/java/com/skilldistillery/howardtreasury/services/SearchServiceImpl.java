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
        
        // Search for collections and add to results
        results.addAll(searchCollections(query, "Collection"));
        
        // Search for stories and add to results
        results.addAll(searchStories(query, "Story"));
        
        // Search for poems and add to results
        results.addAll(searchPoems(query, "Poem"));
        
        // Search for persons and add to results
        results.addAll(searchPersons(query, "Person"));
        
        // Search for miscellanea and add to results
        results.addAll(searchMiscellanea(query, "Miscellanea"));
        
        // Search for blog posts and add to results
        results.addAll(searchBlogPosts(query, "Post"));
        
        return results;
    }
    
    private List<Map<String, Object>> searchCollections(String query, String type) {
        return collectionRepo.findByTitleContaining(query).stream()
                .map(collection -> createResultMap(collection, type))
                .collect(Collectors.toList());
    }
    
//    private List<Map<String, Object>> searchStories(String query, String type) {
//        return storyRepo.findByTitleContaining(query).stream()
//                .map(story -> createResultMap(story, type))
//                .collect(Collectors.toList());
//    }
    
    private List<Map<String, Object>> searchStories(String query, String type) {
    	return storyRepo.findByTitleContainingOrAlternateTitleContaining(query, query).stream()
    			.map(story -> createResultMap(story, type))
    			.collect(Collectors.toList());
    }
    
//    private List<Map<String, Object>> searchStories(String query, String type) {
//        List<Map<String, Object>> results = new ArrayList<>();
//
//        // Search in story titles
//        List<Story> storiesWithMatchingTitle = storyRepo.findByTitleContaining(query);
//        results.addAll(storiesWithMatchingTitle.stream()
//                .map(story -> createResultMap(story, type))
//                .collect(Collectors.toList()));
//
//        // Fetch and parse HTML content asynchronously
//        List<CompletableFuture<Void>> asyncTasks = storiesWithMatchingTitle.stream()
//                .map(story -> CompletableFuture.runAsync(() -> {
//                    String textUrl = story.getTextUrl();
//                    if (textUrl != null) {
//                        String htmlContent = fetchHtmlContent(textUrl); // Implement this method to fetch HTML content
//
//                        if (htmlContent != null) {
//                            String extractedText = parseHtmlAndExtractText(htmlContent); // Implement this method to parse HTML and extract text
//
//                            if (extractedText.toLowerCase().contains(query.toLowerCase())) {
//                                results.add(createResultMap(story, type));
//                            }
//                        }
//                    }
//                }))
//                .collect(Collectors.toList());
//
//        // Wait for all async tasks to complete
//        CompletableFuture<Void> allOf = CompletableFuture.allOf(asyncTasks.toArray(new CompletableFuture[0]));
//        allOf.join();
//
//        return results;
//    }
    
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
            // Fetch the HTML content from the URL
            Document doc = Jsoup.connect(url).get();
            return doc.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String parseHtmlAndExtractText(String htmlContent) {
        // Parse the HTML content and extract text
        Document doc = Jsoup.parse(htmlContent);
        Elements elements = doc.select("p"); // You can adjust this selector based on your HTML structure

        StringBuilder extractedText = new StringBuilder();
        for (Element element : elements) {
            extractedText.append(element.text()).append("\n");
        }

        return extractedText.toString();
    }

}
