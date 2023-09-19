package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Illustrator;
import com.skilldistillery.howardtreasury.repositories.IllustratorRepository;

@Service
public class IllustratorServiceImpl implements IllustratorService {

	@Autowired
	private IllustratorRepository illustratorRepo;

	@Override
	public List<Illustrator> findByCollectionId(int collectionId) {
		return illustratorRepo.findByCollections_Id(collectionId);
	}

	@Override
	public List<Illustrator> findAll() {
		return illustratorRepo.findAll();
	}

	@Override
	public Illustrator find(int illustratorId) {
		
		Optional<Illustrator> illustratorOpt = illustratorRepo.findById(illustratorId);
		if(illustratorOpt.isPresent()) {
			Illustrator illustrator = illustratorOpt.get();
			
			return illustrator;
		}
		
		return null;
	}

	@Override
	public Illustrator create(Illustrator illustrator) {
		
		Illustrator newIllustrator = new Illustrator();
		
		newIllustrator.setName(illustrator.getName());
		
		if(illustrator.getCollections() != null) {
			newIllustrator.setCollections(illustrator.getCollections());
		}
		
		return illustratorRepo.save(newIllustrator);
	}

}
