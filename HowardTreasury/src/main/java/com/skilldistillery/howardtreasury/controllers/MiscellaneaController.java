package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
    public List<Miscellanea> getAllMiscellaneaByCollection(@PathVariable("cid") int collectionId) {
        return miscellaneaService.findByCollectionId(collectionId);
    }
	
}
