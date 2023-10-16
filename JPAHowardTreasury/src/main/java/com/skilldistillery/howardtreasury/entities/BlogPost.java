package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "blog_post")
public class BlogPost {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String content;
	
	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;

    // Add a many-to-one relationship with Blog
    @ManyToOne
    @JoinColumn(name = "blog_id")
    private Blog blog;
    
    // Add a one-to-many relationship with BlogComment
    @OneToMany(mappedBy = "blogPost")
    private List<BlogComment> comments;
}
