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

import com.skilldistillery.howardtreasury.entities.Blog;
import com.skilldistillery.howardtreasury.services.BlogService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class BlogController {
	
	@Autowired
	private BlogService blogService;

	@GetMapping("blogs")
    public ResponseEntity<List<Blog>> getAllBlogs() {
		List<Blog> blogs = blogService.findAll();
		if(!blogs.isEmpty()) {
			return new ResponseEntity<>(blogs, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
    }
	
	@GetMapping("blogs/{bid}")
	public ResponseEntity<Blog> getById(@PathVariable("bid") int blogId) {
		Blog blog = blogService.find(blogId);
		if(blog != null) {
			return new ResponseEntity<>(blog, HttpStatus.OK);
		}
		else return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

}
