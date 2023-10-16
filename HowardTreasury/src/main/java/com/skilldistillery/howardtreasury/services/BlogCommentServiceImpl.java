package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Blog;
import com.skilldistillery.howardtreasury.entities.BlogComment;
import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.BlogCommentRepository;
import com.skilldistillery.howardtreasury.repositories.BlogPostRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class BlogCommentServiceImpl implements BlogCommentService {
	
	@Autowired
	private BlogPostRepository blogPostRepo;
	
	@Autowired
	private BlogCommentRepository blogCommentRepo;
	
	@Autowired
	private UserRepository userRepo;

    @Override
    public List<BlogComment> findAll() {
        return blogCommentRepo.findAll();
    }

    @Override
    public BlogComment findById(int blogCommentId) {
        return blogCommentRepo.findById(blogCommentId).orElse(null);
    }

    @Override
    public List<BlogComment> findByBlogPost(int blogPostId) {
        return blogCommentRepo.findByBlogPost_Id(blogPostId);
    }

    @Override
    public BlogComment create(String username, int blogPostId, BlogComment blogComment) {
    	Optional<BlogPost> blogPostOpt = blogPostRepo.findById(blogPostId);
    	
    	if(blogPostOpt.isPresent()) {
    		BlogPost blogPost = blogPostOpt.get();
    		
    		User user = userRepo.findByUsername(username);
    		if(user == null) {
    			return null;
    		}
    		
    		blogComment.setUser(user);
    		blogComment.setBlogPost(blogPost);
    		
    		blogComment = blogCommentRepo.save(blogComment);
    		List<BlogComment> blogComments = blogPost.getComments();
    		blogComments.add(blogComment);
    		blogPostRepo.save(blogPost);
    		
    		return blogComment;
    	}
    	else {
    		return null;
    	}
    }

    @Override
    public BlogComment update(String username, int blogCommentId, BlogComment blogComment) {
    	Optional<BlogComment> blogCommentOpt = blogCommentRepo.findById(blogCommentId);
    	
        if (blogCommentOpt.isPresent()) {
        	BlogComment existingBlogComment = blogCommentOpt.get();
        	
        	if (existingBlogComment.getUser().getUsername().equals(username)) {
        		existingBlogComment.setContent(blogComment.getContent());
        		return blogCommentRepo.save(blogComment);
        	}
        	else {
        		return null;
        	}
        }
        return null;
    }

    @Override
    public ResponseEntity<Void> delete(String username, int blogCommentId) {
        BlogComment commentToDelete = blogCommentRepo.findById(blogCommentId).orElse(null);
        if (commentToDelete != null) {
            // Implement logic to delete the comment.
            blogCommentRepo.delete(commentToDelete);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    @Override
    public BlogComment createReply(String username, int parentCommentId, BlogComment blogComment) {
        BlogComment parentComment = blogCommentRepo.findById(parentCommentId).orElse(null);
        if (parentComment != null) {
            User user = userRepo.findByUsername(username);
            if (user == null) {
                return null; // User not found, can't create a reply.
            }

            BlogPost parentBlogPost = parentComment.getBlogPost();

            // Set the user, blog post, and parent comment for the reply.
            blogComment.setUser(user);
            blogComment.setBlogPost(parentBlogPost);
            blogComment.setParentComment(parentComment);

            // Save the reply.
            blogComment = blogCommentRepo.save(blogComment);
            return blogComment;
        }
        return null;
    }


    @Override
    public List<BlogComment> findRepliesForComment(int parentCommentId) {
        return blogCommentRepo.findByParentCommentId(parentCommentId);
    }

}
