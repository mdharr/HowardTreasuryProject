package com.skilldistillery.howardtreasury.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Collection;
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
		newCollection.setSeries(collection.getSeries());
		newCollection.setIllustrators(collection.getIllustrators());
		newCollection.setStories(collection.getStories());
		newCollection.setPoems(collection.getPoems());
		newCollection.setPersons(collection.getPersons());
		newCollection.setMiscellaneas(collection.getMiscellaneas());
		newCollection.setCollectionImages(collection.getCollectionImages());
		
		return collectionRepo.save(newCollection);
	}

	@Override
	public Collection update(Collection collection) {
		
		Optional<Collection> existingCollectionOpt = collectionRepo.findById(collection.getId());
		
		if(existingCollectionOpt.isPresent()) {
			Collection existingCollection = existingCollectionOpt.get();
			
			existingCollection.setTitle(collection.getTitle());
			existingCollection.setPublishedAt(collection.getPublishedAt());
			existingCollection.setPageCount(collection.getPageCount());
			existingCollection.setDescription(collection.getDescription());
			existingCollection.setSeries(collection.getSeries());
			existingCollection.setIllustrators(collection.getIllustrators());
			existingCollection.setStories(collection.getStories());
			existingCollection.setPoems(collection.getPoems());
			existingCollection.setPersons(collection.getPersons());
			existingCollection.setMiscellaneas(collection.getMiscellaneas());
			existingCollection.setCollectionImages(collection.getCollectionImages());
			
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
	
}
