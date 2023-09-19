package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.CollectionImage;
import com.skilldistillery.howardtreasury.repositories.CollectionImageRepository;

@Service
public class CollectionImageServiceImpl implements CollectionImageService {

	@Autowired
	private CollectionImageRepository collectionImageRepo;
	

	@Override
	public List<CollectionImage> findByCollectionId(int collectionId) {
		return collectionImageRepo.findByCollections_Id(collectionId);
	}

	@Override
	public List<CollectionImage> findAll() {
		return collectionImageRepo.findAll();
	}

	@Override
	public CollectionImage find(int collectionImageId) {
		Optional<CollectionImage> collectionImageOpt = collectionImageRepo.findById(collectionImageId);
		if(collectionImageOpt.isPresent()) {
			CollectionImage collectionImage = collectionImageOpt.get();
			return collectionImage;
		}
		return null;
	}

	@Override
	public CollectionImage create(CollectionImage collectionImage) {
		CollectionImage newCollectionImage = new CollectionImage();
		
		newCollectionImage.setImageUrl(collectionImage.getImageUrl());
		
		if(collectionImage.getCollections() != null) {
			newCollectionImage.setCollections(collectionImage.getCollections());
		}
		
		return collectionImageRepo.save(newCollectionImage);
	}

	
	
	
}
