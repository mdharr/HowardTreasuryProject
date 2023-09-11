package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.ListContentRepository;

@Service
public class ListContentServiceImpl implements ListContentService {

	@Autowired
	private ListContentRepository listContentRepo;
}
