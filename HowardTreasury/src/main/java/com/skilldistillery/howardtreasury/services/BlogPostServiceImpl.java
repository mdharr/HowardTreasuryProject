package com.skilldistillery.howardtreasury.services;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Blog;
import com.skilldistillery.howardtreasury.entities.BlogComment;
import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.BlogCommentRepository;
import com.skilldistillery.howardtreasury.repositories.BlogPostRepository;
import com.skilldistillery.howardtreasury.repositories.BlogRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class BlogPostServiceImpl implements BlogPostService {
	
	@Autowired
	private BlogRepository blogRepo;

	@Autowired
	private BlogPostRepository blogPostRepo;
	
	@Autowired
	private BlogCommentRepository blogCommentRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<BlogPost> findAll(int blogId) {
		Optional<Blog> blogOpt = blogRepo.findById(blogId);
		if(blogOpt.isPresent()) {
			Blog blog = blogOpt.get();
			
			return blog.getBlogPosts();
		}
		return Collections.emptyList();
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
	public BlogPost create(String username, int blogId, BlogPost blogPost) {
	    Optional<Blog> blogOpt = blogRepo.findById(blogId);
	    
	    if (blogOpt.isPresent()) {
	        Blog blog = blogOpt.get();
	        
	        User user = userRepo.findByUsername(username);
	        if (user == null) {
	            return null;
	        }

	        blogPost.setUser(user);
	        blogPost.setBlog(blog);
	        blogPost.setHidden(false);

	        blogPost = blogPostRepo.save(blogPost);
	        List<BlogPost> blogPosts = blog.getBlogPosts();
	        blogPosts.add(blogPost);

	        blogRepo.save(blog);

	        return blogPost;
	    } else {
	        return null;
	    }
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

	//hard delete
	@Override
	public ResponseEntity<Void> delete(String username, int blogPostId) {
	    Optional<BlogPost> blogPostOpt = blogPostRepo.findById(blogPostId);

	    if (blogPostOpt.isPresent()) {
	        BlogPost blogPost = blogPostOpt.get();
	        
	        if (blogPost.getUser().getUsername().equals(username)) {
	            blogCommentRepo.deleteAll(blogPost.getComments());
	            
	            blogPostRepo.delete(blogPost);
	            
	            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	        } else {
	            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
	        }
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}

	// soft delete
	@Override
	public ResponseEntity<Boolean> softDelete(String username, int blogPostId) {
		Optional<BlogPost> blogPostToDeleteOpt = blogPostRepo.findById(blogPostId);
		
		if(blogPostToDeleteOpt.isPresent()) {
			BlogPost blogPostToDelete = blogPostToDeleteOpt.get();
			if(blogPostToDelete.getUser().getUsername().equals(username)) {
				blogPostToDelete.setHidden(true);
				blogPostRepo.save(blogPostToDelete);
				return ResponseEntity.ok(true);
			}
			else {
				return ResponseEntity.status(HttpStatus.FORBIDDEN).body(false);
			}
		}
		
		return ResponseEntity.notFound().build();
	}
	
}
