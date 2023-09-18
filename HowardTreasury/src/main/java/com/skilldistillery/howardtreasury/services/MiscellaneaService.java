package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Miscellanea;

public interface MiscellaneaService {

	public List<Miscellanea> findByCollectionId(int collectionId);
	
	public List<Miscellanea> findAll();
	
	public Miscellanea find(int miscellaneaId);
	
	public Miscellanea create(Miscellanea miscellanea);
}
