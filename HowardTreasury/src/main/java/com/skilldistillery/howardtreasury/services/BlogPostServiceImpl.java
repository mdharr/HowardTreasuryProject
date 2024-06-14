package com.skilldistillery.howardtreasury.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.dtos.BlogCommentDTO;
import com.skilldistillery.howardtreasury.dtos.BlogPostDTO;
import com.skilldistillery.howardtreasury.dtos.UserDTO;
import com.skilldistillery.howardtreasury.entities.BlogComment;
import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.repositories.BlogCommentRepository;
import com.skilldistillery.howardtreasury.repositories.BlogPostRepository;
import com.skilldistillery.howardtreasury.repositories.UserRepository;

@Service
public class BlogPostServiceImpl implements BlogPostService {

	@Autowired
	private BlogPostRepository blogPostRepo;

	@Autowired
	private BlogCommentRepository blogCommentRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private UserService userService;

	@Autowired
	private BlogCommentService blogCommentService;

	@Override
	public List<BlogPost> findAll() {
		return blogPostRepo.findAll();
	}

	@Override
	public BlogPost find(int blogPostId) {
		Optional<BlogPost> blogPostOpt = blogPostRepo.findById(blogPostId);
		if (blogPostOpt.isPresent()) {
			BlogPost blogPost = blogPostOpt.get();
			return blogPost;
		}
		return null;
	}

	@Override
	public BlogPost create(String username, BlogPost blogPost) {
		User user = userRepo.findByUsername(username);

		if (user == null) {
			return null;
		}
		blogPost.setUser(user);
		blogPost.setHidden(false);
		blogPost = blogPostRepo.save(blogPost);
		return blogPost;
	}

	@Override
	public BlogPost update(String username, int blogPostId, BlogPost blogPost) {
		Optional<BlogPost> existingBlogPostOpt = blogPostRepo.findById(blogPostId);
		if (existingBlogPostOpt.isPresent()) {
			BlogPost existingBlogPost = existingBlogPostOpt.get();

			if (existingBlogPost.getUser().getUsername().equals(username)) {
				existingBlogPost.setTitle(blogPost.getTitle());
				existingBlogPost.setContent(blogPost.getContent());
				existingBlogPost.setImageUrl(blogPost.getImageUrl());
				return blogPostRepo.save(existingBlogPost);
			} else {
				return null;
			}
		}
		return null;
	}

	// hard delete
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

		if (blogPostToDeleteOpt.isPresent()) {
			BlogPost blogPostToDelete = blogPostToDeleteOpt.get();
			if (blogPostToDelete.getUser().getUsername().equals(username)) {
				blogPostToDelete.setHidden(true);
				blogPostRepo.save(blogPostToDelete);
				return ResponseEntity.ok(true);
			} else {
				return ResponseEntity.status(HttpStatus.FORBIDDEN).body(false);
			}
		}

		return ResponseEntity.notFound().build();
	}

	@Override
	public BlogPostDTO mapToDTO(BlogPost blogPost) {
		BlogPostDTO dto = new BlogPostDTO();
		dto.setId(blogPost.getId());
		dto.setTitle(blogPost.getTitle());
		dto.setContent(blogPost.getContent());
		dto.setCreatedAt(blogPost.getCreatedAt());
		dto.setUpdatedAt(blogPost.getUpdatedAt());
		dto.setHidden(blogPost.getHidden());
		dto.setImageUrl(blogPost.getImageUrl());

		UserDTO userDTO = userService.mapUserToDTO(blogPost.getUser());
		dto.setUser(userDTO);

		List<BlogCommentDTO> commentDTOs = new ArrayList<>();

		for (BlogComment comment : blogPost.getComments()) {
			// Recursive function to map comments and their replies
			BlogCommentDTO commentDTO = mapCommentWithRepliesRecursive(comment);
			commentDTOs.add(commentDTO);
		}

		dto.setComments(commentDTOs);

		return dto;
	}

	private BlogCommentDTO mapCommentWithRepliesRecursive(BlogComment comment) {
		BlogCommentDTO commentDTO = new BlogCommentDTO();
		commentDTO.setId(comment.getId());
		commentDTO.setContent(comment.getContent());
		commentDTO.setCreatedAt(comment.getCreatedAt());
		commentDTO.setUpdatedAt(comment.getUpdatedAt());
		commentDTO.setUser(userService.mapUserToDTO(comment.getUser()));
		commentDTO.setHidden(comment.isHidden());
	    if (comment.getParentComment() != null) {
	        commentDTO.setParentComment(blogCommentService.mapToDTO(comment.getParentComment()));
	    }

		List<BlogCommentDTO> replyDTOs = new ArrayList<>();
		int maxDepth = 100;

		for (BlogComment reply : comment.getReplies()) {
			// Recursive function to map replies and nested replies
			BlogCommentDTO replyDTO = mapCommentWithRepliesRecursive(reply);
			replyDTO.setId(reply.getId());
			replyDTO.setContent(reply.getContent());
			replyDTO.setCreatedAt(reply.getCreatedAt());
			replyDTO.setUpdatedAt(reply.getUpdatedAt());
			replyDTO.setUser(userService.mapUserToDTO(reply.getUser()));
			replyDTO.setHidden(reply.isHidden());
			replyDTO.setParentComment(blogCommentService.mapToDTO(reply.getParentComment()));
			replyDTOs.add(replyDTO);
		}

		commentDTO.setReplies(replyDTOs);

		return commentDTO;
	}

}
