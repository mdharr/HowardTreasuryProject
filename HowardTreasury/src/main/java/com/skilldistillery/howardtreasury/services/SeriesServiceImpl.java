package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.SeriesRepository;

@Service
public class SeriesServiceImpl implements SeriesService {

	@Autowired
	private SeriesRepository seriesRepo;
}
