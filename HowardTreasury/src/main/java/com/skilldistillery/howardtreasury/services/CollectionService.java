package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Collection;

public interface CollectionService {

	public List<Collection> findAll();
	
	public Collection find(int collectionId);
	
	public Collection create(Collection collection);
	
	public Collection update(Collection collection);
	
	public void delete(int collectionId);
}
