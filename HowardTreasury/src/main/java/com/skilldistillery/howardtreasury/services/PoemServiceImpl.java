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
