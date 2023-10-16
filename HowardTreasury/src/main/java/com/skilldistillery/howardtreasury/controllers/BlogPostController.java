package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.services.BlogPostService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class BlogPostController {

	@Autowired
	private BlogPostService blogPostService;
	
	@GetMapping("blogs/{bid}/posts")
    public ResponseEntity<List<BlogPost>> getAllBlogPosts(@PathVariable("bid") int blogId) {
		List<BlogPost> blogPosts = blogPostService.findAll(blogId);
		if(!blogPosts.isEmpty()) {
			return new ResponseEntity<>(blogPosts, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
    }
	
	@GetMapping("blogs/{bid}/posts/{bpid}")
	public ResponseEntity<BlogPost> getById(@PathVariable("bid") int blogId, @PathVariable("bpid") int blogPostId) {
		BlogPost blogPost = blogPostService.find(blogPostId);
		if(blogPost != null) {
			return new ResponseEntity<>(blogPost, HttpStatus.OK);
		}
		else return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@PostMapping("blogs/{blogId}/posts")
	public ResponseEntity<BlogPost> createPost(@PathVariable("blogId") int blogId, @RequestBody BlogPost blogPost, Principal principal) {
	    BlogPost createdPost = blogPostService.create(principal.getName(), blogId, blogPost);
	    if (createdPost != null) {
	        return new ResponseEntity<>(createdPost, HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}

	@PutMapping("blogs/{blogId}/posts/{postId}")
	public ResponseEntity<BlogPost> updatePost(@PathVariable("blogId") int blogId, @PathVariable("postId") int postId, @RequestBody BlogPost blogPost, Principal principal) {
	    BlogPost updatedPost = blogPostService.update(principal.getName(), postId, blogPost);
	    if (updatedPost != null) {
	        return new ResponseEntity<>(updatedPost, HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}

	@DeleteMapping("blogs/{blogId}/posts/{postId}")
	public ResponseEntity<Void> deletePost(@PathVariable("blogId") int blogId, @PathVariable("postId") int postId, Principal principal) {
	    ResponseEntity<Void> response = blogPostService.delete(principal.getName(), postId);
	    
	    if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
	        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	    } else if (response.getStatusCode() == HttpStatus.FORBIDDEN) {
	        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}
	
}