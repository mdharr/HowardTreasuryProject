package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Poem;

public interface PoemService {

	public List<Poem> findByCollectionId(int collectionId);

}
