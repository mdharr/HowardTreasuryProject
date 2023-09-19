package com.skilldistillery.howardtreasury.controllers;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.skilldistillery.howardtreasury.entities.Series;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.services.SeriesService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class SeriesController {

	@Autowired
	private SeriesService seriesService;
	
	@GetMapping("series")
	public ResponseEntity<List<Series>> getAllSeries() {
		List<Series> series = seriesService.findAll();
		
		if(series.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(series, HttpStatus.OK);
		}
	}
	
	@GetMapping("series/{sid}")
	public ResponseEntity<Series> getSeriesById(@PathVariable("sid") int seriesId) {
		Series series = seriesService.find(seriesId);
		
		if (series != null) {
			return new ResponseEntity<>(series, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("series")
	public ResponseEntity<Series> createSeries(@RequestBody Series series) {
		
		try {
			Series createdSeries = seriesService.create(series);
			URI location = ServletUriComponentsBuilder.fromCurrentRequest()
					.path("/{id}")
					.buildAndExpand(createdSeries.getId())
					.toUri();
			return ResponseEntity.created(location).body(createdSeries);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
}
