package com.skilldistillery.howardtreasury.controllers;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

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

import com.skilldistillery.howardtreasury.dtos.BlogCommentDTO;
import com.skilldistillery.howardtreasury.dtos.BlogPostDTO;
import com.skilldistillery.howardtreasury.entities.BlogComment;
import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.services.BlogCommentService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class BlogCommentController {

	@Autowired
	private BlogCommentService blogCommentService;
	
//	@GetMapping("comments")
//	public ResponseEntity<List<BlogComment>> getAllComments() {
//	    List<BlogComment> comments = blogCommentService.findAll();
//	    if (!comments.isEmpty()) {
//	        return new ResponseEntity<>(comments, HttpStatus.OK);
//	    } else {
//	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//	    }
//	}
//
//	@GetMapping("comments/{cid}")
//	public ResponseEntity<BlogComment> getCommentById(@PathVariable("cid") int blogCommentId) {
//	    BlogComment comment = blogCommentService.findById(blogCommentId);
//	    if (comment != null) {
//	        return new ResponseEntity<>(comment, HttpStatus.OK);
//	    } else {
//	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//	    }
//	}
	
	// BlogCommentController.java
	@GetMapping("comments")
	public ResponseEntity<List<BlogCommentDTO>> getAllComments() {
	    List<BlogComment> comments = blogCommentService.findAll();
	    if (!comments.isEmpty()) {
	        // Map your BlogComment entities to BlogCommentDTOs
	        List<BlogCommentDTO> commentDTOs = comments.stream()
	                .map(blogCommentService::mapToDTO)
	                .collect(Collectors.toList());
	        return new ResponseEntity<>(commentDTOs, HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}

	@GetMapping("comments/{cid}")
	public ResponseEntity<BlogCommentDTO> getCommentById(@PathVariable("cid") int blogCommentId) {
	    BlogComment comment = blogCommentService.findById(blogCommentId);
	    if (comment != null) {
	        // Map the BlogComment entity to a BlogCommentDTO
	        BlogCommentDTO commentDTO = blogCommentService.mapToDTO(comment);
	        return new ResponseEntity<>(commentDTO, HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}
	
	@GetMapping("posts/{bpid}/comments")
	public ResponseEntity<List<BlogCommentDTO>> getCommentsForBlogPost(@PathVariable("bpid") int blogPostId) {
	    List<BlogComment> comments = blogCommentService.findByBlogPost(blogPostId);
	    if (!comments.isEmpty()) {
	        // Map your BlogComment entities to BlogCommentDTOs
	        List<BlogCommentDTO> commentDTOs = comments.stream()
	                .map(blogCommentService::mapToDTO) // You need to create a mapping method in your service
	                .collect(Collectors.toList());
	        return new ResponseEntity<>(commentDTOs, HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}

//	@GetMapping("blogs/{bid}/posts/{bpid}/comments")
//	public ResponseEntity<List<BlogComment>> getCommentsForBlogPost(@PathVariable("bid") int blogId, @PathVariable("bpid") int blogPostId) {
//	    List<BlogComment> comments = blogCommentService.findByBlogPost(blogPostId);
//	    if (!comments.isEmpty()) {
//	        return new ResponseEntity<>(comments, HttpStatus.OK);
//	    } else {
//	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//	    }
//	}
	
    @PostMapping("posts/{bpid}/comments")
    public ResponseEntity<BlogComment> createComment(@PathVariable("bpid") int blogPostId, @RequestBody BlogComment blogComment, Principal principal) {
        BlogComment createdComment = blogCommentService.create(principal.getName(), blogPostId, blogComment);
        if (createdComment != null) {
            return new ResponseEntity<>(createdComment, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("posts/{bpid}/comments/{cid}")
    public ResponseEntity<BlogComment> updateComment(@PathVariable("bpid") int blogPostId, @PathVariable("cid") int blogCommentId, @RequestBody BlogComment blogComment, Principal principal) {
        BlogComment updatedComment = blogCommentService.update(principal.getName(), blogCommentId, blogComment);
        if (updatedComment != null) {
            return new ResponseEntity<>(updatedComment, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }
    }

    @DeleteMapping("posts/{bpid}/comments/{cid}")
    public ResponseEntity<Boolean> deleteComment(@PathVariable("bpid") int blogPostId, @PathVariable("cid") int blogCommentId, Principal principal) {
        ResponseEntity<Boolean> response = blogCommentService.delete(principal.getName(), blogCommentId);
        if (response.getStatusCode() == HttpStatus.OK) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else if (response.getStatusCode() == HttpStatus.FORBIDDEN) {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        } else {
            return new ResponseEntity<>(false, HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("posts/{bpid}/comments/{cid}/replies")
    public ResponseEntity<BlogComment> createReply(@PathVariable("bpid") int blogPostId, @PathVariable("cid") int parentCommentId, @RequestBody BlogComment blogComment, Principal principal) {
        BlogComment createdReply = blogCommentService.createReply(principal.getName(), parentCommentId, blogComment);
        if (createdReply != null) {
            return new ResponseEntity<>(createdReply, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("posts/{bpid}/comments/{cid}/replies")
    public ResponseEntity<List<BlogComment>> getRepliesForComment(@PathVariable("bpid") int blogPostId, @PathVariable("cid") int parentCommentId) {
        List<BlogComment> replies = blogCommentService.findRepliesForComment(parentCommentId);
        if (!replies.isEmpty()) {
            return new ResponseEntity<>(replies, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
