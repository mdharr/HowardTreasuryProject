package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.WeirdTales;
import com.skilldistillery.howardtreasury.services.WeirdTalesService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class WeirdTalesController {

	@Autowired
	private WeirdTalesService weirdTalesService;
	
	@GetMapping("weird-tales")
	public ResponseEntity<List<WeirdTales>> getAllWeirdTales() {
		List<WeirdTales> weirdTales = weirdTalesService.findAll();
		
		if(weirdTales.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(weirdTales, HttpStatus.OK);
		}
	}
	
	@GetMapping("weird-tales/{wtid}")
	public ResponseEntity<WeirdTales> getWeirdTalesById(@PathVariable("wtid") int weirdTalesId) {
		WeirdTales weirdTales = weirdTalesService.find(weirdTalesId);
		
		if (weirdTales != null) {
			return new ResponseEntity<>(weirdTales, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
}
