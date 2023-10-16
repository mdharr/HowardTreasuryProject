package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "blog_comment")
public class BlogComment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String content;
	
	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;
	
    // Add a many-to-one relationship with User to represent the author of the comment
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    // Add a many-to-one relationship with BlogPost
    @ManyToOne
    @JoinColumn(name = "blog_post_id")
    private BlogPost blogPost;
    
    // Add a self-referencing relationship for replies
    @ManyToOne
    @JoinColumn(name = "parent_comment_id")
    private BlogComment parentComment;

}
