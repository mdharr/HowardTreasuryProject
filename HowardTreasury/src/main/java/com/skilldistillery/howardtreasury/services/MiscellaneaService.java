package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Miscellanea;

public interface MiscellaneaService {

	public List<Miscellanea> findByCollectionId(int collectionId);
}
