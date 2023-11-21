package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.WeirdTales;
import com.skilldistillery.howardtreasury.repositories.WeirdTalesRepository;

@Service
public class WeirdTalesServiceImpl implements WeirdTalesService {
	
	@Autowired
	private WeirdTalesRepository weirdTalesRepo;

	@Override
	public List<WeirdTales> findAll() {
		return weirdTalesRepo.findAll();
	}

	@Override
	public WeirdTales find(int weirdTalesId) {
		Optional<WeirdTales> weirdTalesOpt = weirdTalesRepo.findById(weirdTalesId);
		if(weirdTalesOpt.isPresent()) {
			WeirdTales weirdTales = weirdTalesOpt.get();
			return weirdTales;
		}
		return null;
	}

}
