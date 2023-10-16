package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.skilldistillery.howardtreasury.entities.BlogPost;

public interface BlogPostService {

	public List<BlogPost> findAll();
	
	public BlogPost find(int blogPostId);
	
	public BlogPost create(String username, int blogId, BlogPost blogPost);
	
	public BlogPost update(String username, int blogPostId, BlogPost blogPost);
	
	public ResponseEntity<Void> delete(String username, int blogPostId);
}
