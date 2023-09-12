package com.skilldistillery.howardtreasury.services;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection update(Collection collection) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(int collectionId) {
		// TODO Auto-generated method stub
		
	}
	
}
