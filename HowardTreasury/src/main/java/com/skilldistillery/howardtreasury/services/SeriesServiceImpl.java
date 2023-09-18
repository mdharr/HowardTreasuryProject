package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Series;
import com.skilldistillery.howardtreasury.repositories.SeriesRepository;

@Service
public class SeriesServiceImpl implements SeriesService {

	@Autowired
	private SeriesRepository seriesRepo;

	@Override
	public List<Series> findAll() {
		return seriesRepo.findAll();
	}
}
