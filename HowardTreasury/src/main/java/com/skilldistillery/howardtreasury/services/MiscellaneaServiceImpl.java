package com.skilldistillery.howardtreasury.services;

import java.util.List;

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
}
