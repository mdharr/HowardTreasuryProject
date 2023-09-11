package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.CollectionImageRepository;

@Service
public class CollectionImageServiceImpl implements CollectionImageService {

	@Autowired
	private CollectionImageRepository collectionImageRepo;
}
