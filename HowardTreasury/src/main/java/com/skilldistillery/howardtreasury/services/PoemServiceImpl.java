package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;

@Service
public class PoemServiceImpl implements PoemService {

	@Autowired
	private PoemRepository poemRepo;

	@Override
	public List<Poem> findByCollectionId(int collectionId) {
		return poemRepo.findByCollections_Id(collectionId);
	}

	@Override
	public List<Poem> findAll() {
		return poemRepo.findAll();
	}
}

//public Collection create(Collection collection) {
//
//Collection newCollection = new Collection();
//
//newCollection.setTitle(collection.getTitle());
//
//if (collection.getSeries() != null) {
//	newCollection.setSeries(collection.getSeries());
//}
//
//if (collection.getStories() != null) {
//    newCollection.setStories(collection.getStories());
//}
//
//return collectionRepo.save(newCollection);
//}
