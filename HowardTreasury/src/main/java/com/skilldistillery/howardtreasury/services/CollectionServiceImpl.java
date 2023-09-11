package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.CollectionRepository;

@Service
public class CollectionServiceImpl implements CollectionService {

	@Autowired
	private CollectionRepository collectionRepo;
}
