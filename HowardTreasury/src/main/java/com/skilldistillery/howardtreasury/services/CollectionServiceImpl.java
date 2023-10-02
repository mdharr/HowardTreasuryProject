package com.skilldistillery.howardtreasury.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.CollectionDetailsDTO;
import com.skilldistillery.howardtreasury.dtos.CollectionWithStoriesDTO;
import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.CollectionHasMiscellanea;
import com.skilldistillery.howardtreasury.entities.CollectionHasPoem;
import com.skilldistillery.howardtreasury.entities.CollectionHasStory;
import com.skilldistillery.howardtreasury.entities.CollectionImage;
import com.skilldistillery.howardtreasury.entities.Illustrator;
import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Series;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.repositories.CollectionHasMiscellaneaRepository;
import com.skilldistillery.howardtreasury.repositories.CollectionHasPoemRepository;
import com.skilldistillery.howardtreasury.repositories.CollectionHasStoryRepository;
import com.skilldistillery.howardtreasury.repositories.CollectionRepository;

@Service
public class CollectionServiceImpl implements CollectionService {

	@Autowired
	private CollectionRepository collectionRepo;
	
	@Autowired
	private CollectionHasStoryRepository collectionHasStoryRepo;
	
	@Autowired
	private CollectionHasPoemRepository collectionHasPoemRepo;
	
	@Autowired
	private CollectionHasMiscellaneaRepository collectionHasMiscellaneaRepo;

	@Override
	public List<Collection> findAll() {
		return collectionRepo.findAll();
	}

	@Override
	public Collection find(int collectionId) {
		
		Optional<Collection> collectionOpt = collectionRepo.findById(collectionId);
		if(collectionOpt.isPresent()) {
			Collection collection = collectionOpt.get();
			return collection;
		}
		return null;
	}

	@Override
	public Collection create(Collection collection) {
		
		Collection newCollection = new Collection();
		
		
		newCollection.setTitle(collection.getTitle());
		newCollection.setPublishedAt(collection.getPublishedAt());
		newCollection.setPageCount(collection.getPageCount());
		newCollection.setDescription(collection.getDescription());
		
		if (collection.getSeries() != null) {
			newCollection.setSeries(collection.getSeries());
		}
		
		if (collection.getIllustrators() != null) {
		    newCollection.setIllustrators(collection.getIllustrators());
		}
		
		if (collection.getStories() != null) {
		    newCollection.setStories(collection.getStories());
		}
		
		if (collection.getPoems() != null) {
			newCollection.setPoems(collection.getPoems());
		}
		
		if (collection.getPersons() != null) {
			newCollection.setPersons(collection.getPersons());
		}
		
		if (collection.getMiscellaneas() != null) {
			newCollection.setMiscellaneas(collection.getMiscellaneas());
		}
		
		if (collection.getCollectionImages() != null) {
			newCollection.setCollectionImages(collection.getCollectionImages());
		}
		
		return collectionRepo.save(newCollection);
	}

	@Override
	public Collection update(int collectionId, Collection collection) {
	    Optional<Collection> existingCollectionOpt = collectionRepo.findById(collectionId);

	    if (existingCollectionOpt.isPresent()) {
	        Collection existingCollection = existingCollectionOpt.get();

	        // Use reflection to loop through the properties of the Collection class
	        for (Field field : Collection.class.getDeclaredFields()) {
	            try {
	            	// skip id property
	                if (field.getName().equals("id")) {
	                    continue;
	                }
	                
	                // Set the field to accessible (to access private fields)
	                field.setAccessible(true);

	                // Get the value of the corresponding field in the incoming collection
	                Object value = field.get(collection);
	                
	                // Update the field in the existing collection if the value is not null
	                if (value != null) {
	                    field.set(existingCollection, value);
	                }
	            } catch (IllegalAccessException e) {
	                // Handle any exceptions that may occur during reflection
	                e.printStackTrace();
	            } finally {
	                // Always set the accessibility back to false when done
	                field.setAccessible(false);
	            }
	        }

	        // Save the updated entity back to the database
	        return collectionRepo.save(existingCollection);
	    }

	    return null;
	}

	@Override
	public void delete(int collectionId) {
		
		Optional<Collection> collectionOpt = collectionRepo.findById(collectionId);
		
		if(collectionOpt.isPresent()) {
			Collection collection = collectionOpt.get();
			
//			collection.setSeries(null);
			collection.setIllustrators(new ArrayList<>());
			collection.setStories(new ArrayList<>());
			collection.setPoems(new ArrayList<>());
			collection.setPersons(new ArrayList<>());
			collection.setMiscellaneas(new ArrayList<>());
			collection.setCollectionImages(new ArrayList<>());
			
			collectionRepo.delete(collection);
		}
	}
	
	@Override
	public Collection getByTitle(String collectionTitle) {
		return collectionRepo.findByTitle(collectionTitle);
	}
	
	@Override
	public CollectionWithStoriesDTO findCollectionWithStories(int collectionId) {
	    Optional<Collection> collectionOpt = collectionRepo.findById(collectionId);
	    if (collectionOpt.isPresent()) {
	        Collection collection = collectionOpt.get();
	        CollectionWithStoriesDTO dto = new CollectionWithStoriesDTO();
	        
	        // Populate basic collection details
	        dto.setId(collection.getId());
	        dto.setTitle(collection.getTitle());
	        dto.setPublishedAt(collection.getPublishedAt());
	        dto.setPageCount(collection.getPageCount());
	        dto.setDescription(collection.getDescription());
	        dto.setSeries(collection.getSeries());
	        
	        // Populate stories with page numbers
	        List<CollectionHasStory> collectionHasStories = collectionHasStoryRepo.findByCollectionId(collectionId);
	        List<CollectionHasPoem> collectionHasPoems = collectionHasPoemRepo.findByCollectionId(collectionId);
	        List<CollectionHasMiscellanea> collectionHasMiscellaneas = collectionHasMiscellaneaRepo.findByCollectionId(collectionId);
	        
	        List<CollectionWithStoriesDTO.StoryWithPageNumberDTO> storyDTOs = new ArrayList<>();
	        List<CollectionWithStoriesDTO.PoemWithPageNumberDTO> poemDTOs = new ArrayList<>();
	        List<CollectionWithStoriesDTO.MiscellaneaWithPageNumberDTO> miscellaneaDTOs = new ArrayList<>();

	        for (CollectionHasStory collectionHasStory : collectionHasStories) {
	            CollectionWithStoriesDTO.StoryWithPageNumberDTO storyDTO = new CollectionWithStoriesDTO.StoryWithPageNumberDTO();

	            Story story = collectionHasStory.getStory();
	            
	            storyDTO.setId(story.getId());
	            storyDTO.setTitle(story.getTitle());
	            storyDTO.setTextUrl(story.getTextUrl());
	            storyDTO.setFirstPublished(story.getFirstPublished());
	            storyDTO.setAlternateTitle(story.getAlternateTitle());
	            storyDTO.setIsCopyrighted(story.getIsCopyrighted());
	            storyDTO.setCopyrightExpiresAt(story.getCopyrightExpiresAt());
	            storyDTO.setExcerpt(story.getExcerpt());
	            storyDTO.setDescription(story.getDescription());
	            storyDTO.setStoryImages(story.getStoryImages());
	            storyDTO.setPageNumber(collectionHasStory.getPageNumber());
	            
	            storyDTOs.add(storyDTO);
	        }
	        
	        for (CollectionHasPoem collectionHasPoem : collectionHasPoems) {
	        	CollectionWithStoriesDTO.PoemWithPageNumberDTO poemDTO = new CollectionWithStoriesDTO.PoemWithPageNumberDTO();
	        	
	        	Poem poem = collectionHasPoem.getPoem();
	        	
	        	poemDTO.setId(poem.getId());
	        	poemDTO.setTitle(poem.getTitle());
	        	poemDTO.setTextUrl(poem.getTextUrl());
	        	poemDTO.setExcerpt(poem.getExcerpt());
	        	poemDTO.setPageNumber(collectionHasPoem.getPageNumber());
	        	
	        	poemDTOs.add(poemDTO);
	        }
	        
	        for (CollectionHasMiscellanea collectionHasMiscellanea : collectionHasMiscellaneas) {
	        	CollectionWithStoriesDTO.MiscellaneaWithPageNumberDTO miscellaneaDTO = new CollectionWithStoriesDTO.MiscellaneaWithPageNumberDTO();
	        	
	        	Miscellanea miscellanea = collectionHasMiscellanea.getMiscellanea();
	        	
	        	miscellaneaDTO.setId(miscellanea.getId());
	        	miscellaneaDTO.setTitle(miscellanea.getTitle());
	        	miscellaneaDTO.setTextUrl(miscellanea.getTextUrl());
	        	miscellaneaDTO.setExcerpt(miscellanea.getExcerpt());
	        	miscellaneaDTO.setPageNumber(collectionHasMiscellanea.getPageNumber());
	        	
	        	miscellaneaDTOs.add(miscellaneaDTO);
	        }
	        
	        dto.setStories(storyDTOs);
	        dto.setPoems(poemDTOs);
	        dto.setPersons(collection.getPersons());
	        dto.setMiscellaneas(miscellaneaDTOs);
	        dto.setCollectionImages(collection.getCollectionImages());
	        dto.setIllustrators(collection.getIllustrators());
	        
	        return dto;
	    }
	    return null;
	}

	
    @Override
    public List<CollectionHasStory> findStoriesByCollectionOrderByPageNumberAsc(Collection collection) {
        return collectionHasStoryRepo.findStoriesByCollectionOrderByPageNumberAsc(collection);
    }
	
	@Override
    public CollectionDetailsDTO findCollectionDetails(int collectionId) {
        Optional<Collection> collectionOpt = collectionRepo.findById(collectionId);
        
        if (collectionOpt.isPresent()) {
            Collection collection = collectionOpt.get();
            
            Map<String, Object> response = new HashMap<>();
            
            response.put("stories", collection.getStories());
            response.put("poems", collection.getPoems());
            response.put("persons", collection.getPersons());
            response.put("miscellaneas", collection.getMiscellaneas());
            
            for (String key : response.keySet()) {
				
            	Object value = response.get(key);
            	
            	System.out.print("Key:" + key);
            	System.out.println("Value:" + value);
			}
            
            Series series = collection.getSeries();
            List<Story> stories = collection.getStories();
            List<Poem> poems = collection.getPoems();
            List<Person> persons = collection.getPersons();
            List<Miscellanea> miscellaneas = collection.getMiscellaneas();
            List<Illustrator> illustrators = collection.getIllustrators();
            List<CollectionImage> collectionImages = collection.getCollectionImages();

            // Create and populate the DTO
            CollectionDetailsDTO collectionDetailsDTO = new CollectionDetailsDTO();
            collectionDetailsDTO.setCollection(collection);
            collectionDetailsDTO.setSeries(series);
            collectionDetailsDTO.setStories(stories);
            collectionDetailsDTO.setPoems(poems);
            collectionDetailsDTO.setPersons(persons);
            collectionDetailsDTO.setMiscellaneas(miscellaneas);
            collectionDetailsDTO.setIllustrators(illustrators);
            collectionDetailsDTO.setCollectionImages(collectionImages);

            return collectionDetailsDTO;
        }

        return null;
    }

	@Override
	public List<Collection> getByPoemId(int poemId) {
		return collectionRepo.findByPoems_Id(poemId);
	}

}
