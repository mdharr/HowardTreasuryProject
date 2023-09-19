package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.CollectionImage;

public interface CollectionImageService {
	
	public List<CollectionImage> findByCollectionId(int collectionId);

	public List<CollectionImage> findAll();
	
	public CollectionImage find(int collectionImageId);
	
	public CollectionImage create(CollectionImage collectionImage);
}
