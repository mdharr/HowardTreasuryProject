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

//public Collection create(Collection collection) {
//
//Collection newCollection = new Collection();
//
//newCollection.setTitle(collection.getTitle());
//
//if (collection.getSeries() != null) {
//	newCollection.setSeries(collection.getSeries());
//}
//
//if (collection.getStories() != null) {
//    newCollection.setStories(collection.getStories());
//}
//
//return collectionRepo.save(newCollection);
//}
