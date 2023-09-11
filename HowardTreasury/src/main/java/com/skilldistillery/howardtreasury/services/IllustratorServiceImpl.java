package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.IllustratorRepository;

@Service
public class IllustratorServiceImpl implements IllustratorService {

	@Autowired
	private IllustratorRepository illustratorRepo;
}
