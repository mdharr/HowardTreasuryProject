package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.repositories.MiscellaneaRepository;

@Service
public class MiscellaneaServiceImpl implements MiscellaneaService {

	@Autowired
	private MiscellaneaRepository miscellaneaRepo;

	@Override
	public List<Miscellanea> findByCollectionId(int collectionId) {
		return miscellaneaRepo.findByCollections_Id(collectionId);
	}

	@Override
	public List<Miscellanea> findAll() {
		return miscellaneaRepo.findAll();
	}

	@Override
	public Miscellanea find(int miscellaneaId) {
		Optional<Miscellanea> miscellaneaOpt = miscellaneaRepo.findById(miscellaneaId);
		if(miscellaneaOpt.isPresent()) {
			Miscellanea miscellanea = miscellaneaOpt.get();
			return miscellanea;
		}
		return null;
	}

	@Override
	public Miscellanea create(Miscellanea miscellanea) {
		Miscellanea newMiscellanea = new Miscellanea();
		
		newMiscellanea.setTitle(miscellanea.getTitle());
		
		if(miscellanea.getCollections() != null) {
			newMiscellanea.setCollections(miscellanea.getCollections());
		}
		
		return miscellaneaRepo.save(newMiscellanea);
	}

}
