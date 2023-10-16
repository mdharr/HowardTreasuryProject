package com.skilldistillery.howardtreasury.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.skilldistillery.howardtreasury.entities.BlogComment;

public interface BlogCommentService {
	
	public List<BlogComment> findAll();
	
	public BlogComment findById(int blogCommentId);
	
	public List<BlogComment> findByBlogPost(int blogPostId);
	
	public BlogComment create(String username, int blogPostId, BlogComment blogComment);
	
	public BlogComment update(String username, int blogCommentId, BlogComment blogComment);
	
	public ResponseEntity<Void> delete(String username, int blogCommentId);
	
    public BlogComment createReply(String username, int parentCommentId, BlogComment blogComment);
    
    public List<BlogComment> findRepliesForComment(int parentCommentId);

}
