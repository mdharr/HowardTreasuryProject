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

import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.services.MiscellaneaService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class MiscellaneaController {

	@Autowired
	private MiscellaneaService miscellaneaService;
	
	@GetMapping("collections/{cid}/miscellaneas")
    public ResponseEntity<List<Miscellanea>> getAllMiscellaneaByCollection(@PathVariable("cid") int collectionId) {
		List<Miscellanea> miscellaneas = miscellaneaService.findByCollectionId(collectionId);
		
		if (miscellaneas.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(miscellaneas, HttpStatus.OK);
		}
		
    }
	
	@GetMapping("miscellaneas")
	public ResponseEntity<List<Miscellanea>> getAllMiscellanea() {
		List<Miscellanea> miscellaneas = miscellaneaService.findAll();
		
		if (miscellaneas.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		else {
			return new ResponseEntity<>(miscellaneas, HttpStatus.OK);
		}
		
	}
	
	@GetMapping("miscellaneas/{mid}")
	public ResponseEntity<Miscellanea> getMiscellaneaById(@PathVariable("mid") int miscellaneaId) {
		Miscellanea miscellanea = miscellaneaService.find(miscellaneaId);
		
		if (miscellanea != null) {
			return new ResponseEntity<>(miscellanea, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
}
