package com.skilldistillery.howardtreasury.services;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.CollectionDetailsDTO;
import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.repositories.CollectionRepository;

@Service
public class CollectionServiceImpl implements CollectionService {

	@Autowired
	private CollectionRepository collectionRepo;

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
    public CollectionDetailsDTO findCollectionDetails(int collectionId) {
        Optional<Collection> collectionOpt = collectionRepo.findById(collectionId);

        if (collectionOpt.isPresent()) {
            Collection collection = collectionOpt.get();
            List<Story> stories = collection.getStories();
            List<Poem> poems = collection.getPoems();
            List<Person> persons = collection.getPersons();
            List<Miscellanea> miscellaneas = collection.getMiscellaneas();

            // Create and populate the DTO
            CollectionDetailsDTO collectionDetailsDTO = new CollectionDetailsDTO();
            collectionDetailsDTO.setCollection(collection);
            collectionDetailsDTO.setStories(stories);
            collectionDetailsDTO.setPoems(poems);
            collectionDetailsDTO.setPersons(persons);
            collectionDetailsDTO.setMiscellaneas(miscellaneas);

            return collectionDetailsDTO;
        }

        return null;
    }
	
}
