package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Illustrator;

public interface IllustratorService {
	
	public List<Illustrator> findByCollectionId(int collectionId);

	public List<Illustrator> findAll();
	
	public Illustrator find(int illustratorId);
	
	public Illustrator create(Illustrator illustrator);
}
