package com.skilldistillery.howardtreasury.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.BlogCommentDTO;
import com.skilldistillery.howardtreasury.dtos.UserDTO;
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
	
	@Autowired
	private UserService userService;

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
    		blogComment.setHidden(false);
    		
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
    public BlogComment update(String username, int blogCommentId, BlogComment updatedComment) {
        Optional<BlogComment> blogCommentOpt = blogCommentRepo.findById(blogCommentId);
        
        if (blogCommentOpt.isPresent()) {
            BlogComment existingBlogComment = blogCommentOpt.get();
            
            if (existingBlogComment.getUser().getUsername().equals(username)) {
                existingBlogComment.setContent(updatedComment.getContent()); // Update the content of the existing comment.
                return blogCommentRepo.save(existingBlogComment); // Save the existing comment with updated content.
            } else {
                return null;
            }
        }
        return null;
    }


    @Override
    public ResponseEntity<Boolean> delete(String username, int blogCommentId) {
        Optional<BlogComment> commentToDeleteOpt = blogCommentRepo.findById(blogCommentId);
        
        if (commentToDeleteOpt.isPresent()) {
      	  BlogComment commentToDelete = commentToDeleteOpt.get();
            if (commentToDelete.getUser().getUsername().equals(username)) {
                commentToDelete.setHidden(true);
                blogCommentRepo.save(commentToDelete);
                return ResponseEntity.ok(true);
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(false);
            }
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
            blogComment.setHidden(false);

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
    
    @Override
    public BlogCommentDTO mapToDTO(BlogComment blogComment) {
        BlogCommentDTO dto = new BlogCommentDTO();
        dto.setId(blogComment.getId());
        dto.setContent(blogComment.getContent());
        dto.setCreatedAt(blogComment.getCreatedAt());
        dto.setUser(userService.mapUserToDTO(blogComment.getUser()));
        dto.setHidden(blogComment.isHidden());

        List<BlogCommentDTO> replyDTOs = new ArrayList<>();
        int maxDepth = 100;

        for (BlogComment reply : blogComment.getReplies()) {
            // Recursive function to map replies and nested replies
            BlogCommentDTO replyDTO = mapCommentWithRepliesRecursive(reply);
            replyDTOs.add(replyDTO);
        }

        dto.setReplies(replyDTOs);

        return dto;
    }

    private BlogCommentDTO mapCommentWithRepliesRecursive(BlogComment comment) {
        BlogCommentDTO commentDTO = new BlogCommentDTO();
        commentDTO.setId(comment.getId());
        commentDTO.setContent(comment.getContent());
        commentDTO.setCreatedAt(comment.getCreatedAt());
        commentDTO.setUser(userService.mapUserToDTO(comment.getUser()));
        commentDTO.setHidden(comment.isHidden());

        List<BlogCommentDTO> replyDTOs = new ArrayList<>();
        int maxDepth = 100;

        for (BlogComment reply : comment.getReplies()) {
            // Recursive function to map replies and nested replies
            BlogCommentDTO replyDTO = mapCommentWithRepliesRecursive(reply);
            replyDTOs.add(replyDTO);
        }

        commentDTO.setReplies(replyDTOs);

        return commentDTO;
    }



    private BlogCommentDTO mapCommentWithoutRepliesRecursive(BlogComment comment) {
        BlogCommentDTO commentDTO = new BlogCommentDTO();
        commentDTO.setId(comment.getId());
        commentDTO.setContent(comment.getContent());
        commentDTO.setCreatedAt(comment.getCreatedAt());
        commentDTO.setUser(userService.mapUserToDTO(comment.getUser()));
        commentDTO.setHidden(comment.isHidden());
        return commentDTO;
    }


}
