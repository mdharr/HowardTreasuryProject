package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.MiscellaneaRepository;

@Service
public class MiscellaneaServiceImpl implements MiscellaneaService {

	@Autowired
	private MiscellaneaRepository miscellaneaRepo;
}
