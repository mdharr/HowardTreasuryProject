package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.PoemRepository;

@Service
public class PoemServiceImpl implements PoemService {

	@Autowired
	private PoemRepository poemRepo;
}
