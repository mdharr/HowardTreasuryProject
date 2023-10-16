package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.repositories.BlogPostRepository;

@Service
public class BlogPostServiceImpl implements BlogPostService {

	@Autowired
	private BlogPostRepository blogPostRepo;

	@Override
	public List<BlogPost> findAll() {
		return blogPostRepo.findAll();
	}

	@Override
	public BlogPost find(int blogPostId) {
		Optional<BlogPost> blogPostOpt = blogPostRepo.findById(blogPostId);
		if(blogPostOpt.isPresent()) {
			BlogPost blogPost = blogPostOpt.get();
			return blogPost;
		}
		return null;
	}

	@Override
	public BlogPost create(String username, BlogPost blogPost) {
		return blogPostRepo.save(blogPost);
	}
	
	@Override
	public BlogPost update(String username, int blogPostId, BlogPost blogPost) {
		Optional<BlogPost> existingBlogPostOpt = blogPostRepo.findById(blogPostId);
		if(existingBlogPostOpt.isPresent()) {
			BlogPost existingBlogPost = existingBlogPostOpt.get();
			
			if(existingBlogPost.getUser().getUsername().equals(username)) {
				existingBlogPost.setTitle(blogPost.getTitle());
				existingBlogPost.setContent(blogPost.getContent());
				return blogPostRepo.save(existingBlogPost);
			} else {
				return null;
			}
		}
		return null;
	}

	@Override
	public ResponseEntity<Void> delete(String username, int blogPostId) {
		Optional<BlogPost> blogPostOpt = blogPostRepo.findById(blogPostId);
		
		if(blogPostOpt.isPresent()) {
			BlogPost blogPost = blogPostOpt.get();
			if(blogPost.getUser().getUsername().equals(username)) {
				blogPostRepo.delete(blogPost);
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			}
			else {
				return new ResponseEntity<>(HttpStatus.FORBIDDEN);
			}
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
}
