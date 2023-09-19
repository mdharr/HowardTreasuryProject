package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

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

	@Override
	public Series find(int seriesId) {
		Optional<Series> seriesOpt = seriesRepo.findById(seriesId);
		if(seriesOpt.isPresent()) {
			Series series = seriesOpt.get();
			return series;
		}
		return null;
	}

	@Override
	public Series create(Series series) {
		
		Series newSeries = new Series();
		
		newSeries.setTitle(series.getTitle());
		
		if(series.getCollections() != null) {
			newSeries.setCollections(series.getCollections());
		}
		
		return seriesRepo.save(newSeries);
	}
}
