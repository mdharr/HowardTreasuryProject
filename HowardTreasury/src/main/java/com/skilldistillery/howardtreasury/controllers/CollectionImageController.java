package com.skilldistillery.howardtreasury.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.services.CollectionImageService;

@RestController
@CrossOrigin({"*", "http://localhost"})
public class CollectionImageController {

	@Autowired
	private CollectionImageService collectionImageService;
	
}
