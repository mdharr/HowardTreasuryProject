package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.skilldistillery.howardtreasury.dtos.BlogPostDTO;
import com.skilldistillery.howardtreasury.entities.BlogPost;

public interface BlogPostService {

	public List<BlogPost> findAll();
	
	public BlogPost find(int blogPostId);
	
	public BlogPost create(String username, BlogPost blogPost);
	
	public BlogPost update(String username, int blogPostId, BlogPost blogPost);
	
	public ResponseEntity<Void> delete(String username, int blogPostId);
	
	public ResponseEntity<Boolean> softDelete(String username, int blogPostId);
	
	public BlogPostDTO mapToDTO(BlogPost blogPost);

}
