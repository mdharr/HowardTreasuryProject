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
	
	@PostMapping("miscellaneas")
	public ResponseEntity<Miscellanea> createMiscellanea(@RequestBody Miscellanea miscellanea) {
		
	    try {
	    	Miscellanea createdMiscellanea = miscellaneaService.create(miscellanea);
	        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
	            .path("/{id}")
	            .buildAndExpand(createdMiscellanea.getId())
	            .toUri();
	        return ResponseEntity.created(location).body(createdMiscellanea);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	    }
	}
	
//	@PostMapping("miscellaneas")
//	public ResponseEntity<Miscellanea> create(@RequestBody Miscellanea miscellanea) {
//		Miscellanea createdMiscellanea = miscellaneaService.create(miscellanea);
//	    if (createdMiscellanea != null) {
//	        return new ResponseEntity<>(createdMiscellanea, HttpStatus.CREATED);
//	    } else {
//	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//	    }
//	}
	
}
