package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Series;

public interface SeriesService {

	public List<Series> findAll();
	
	public Series find(int seriesId);
	
	public Series create(Series series);
}
