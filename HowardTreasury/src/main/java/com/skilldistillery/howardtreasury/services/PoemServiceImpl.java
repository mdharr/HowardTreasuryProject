package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

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

	@Override
	public Poem find(int poemId) {
		Optional<Poem> poemOpt = poemRepo.findById(poemId);
		if(poemOpt.isPresent()) {
			Poem poem = poemOpt.get();
			return poem;
		}
		return null;
	}

	@Override
	public Poem create(Poem poem) {
		Poem newPoem = new Poem();
		newPoem.setTitle(poem.getTitle());
		
		if (poem.getCollections() != null) {
			newPoem.setCollections(poem.getCollections());
		}
		
		if (poem.getUserLists() != null) {
			newPoem.setUserLists(poem.getUserLists());
		}
		
		return poemRepo.save(newPoem);
	}
}
