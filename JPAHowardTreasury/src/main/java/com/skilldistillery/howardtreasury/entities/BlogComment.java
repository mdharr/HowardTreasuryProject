package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

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
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

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
	
	@UpdateTimestamp
	@Column(name = "updated_at")
	private LocalDateTime updatedAt;
	
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "blog_post_id")
    private BlogPost blogPost;
    
	@JsonBackReference("blogComment-replies")
    @ManyToOne
    @JoinColumn(name = "parent_comment_id")
    private BlogComment parentComment;
    
    @JsonManagedReference("blogComment-replies")
    @OneToMany(mappedBy = "parentComment")
    private List<BlogComment> replies;
    
    private Boolean hidden;

	public BlogComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BlogComment(int id, String content, LocalDateTime createdAt, LocalDateTime updatedAt, User user, BlogPost blogPost,
			BlogComment parentComment, List<BlogComment> replies, Boolean hidden) {
		super();
		this.id = id;
		this.content = content;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.user = user;
		this.blogPost = blogPost;
		this.parentComment = parentComment;
		this.replies = replies;
		this.hidden = hidden;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public BlogPost getBlogPost() {
		return blogPost;
	}

	public void setBlogPost(BlogPost blogPost) {
		this.blogPost = blogPost;
	}

	public BlogComment getParentComment() {
		return parentComment;
	}

	public void setParentComment(BlogComment parentComment) {
		this.parentComment = parentComment;
	}

	public List<BlogComment> getReplies() {
		return replies;
	}

	public void setReplies(List<BlogComment> replies) {
		this.replies = replies;
	}

	public Boolean isHidden() {
		return hidden;
	}

	public void setHidden(Boolean hidden) {
		this.hidden = hidden;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BlogComment other = (BlogComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "BlogComment [id=" + id + ", content=" + content + ", createdAt=" + createdAt + ", user=" + user
				+ ", blogPost=" + blogPost + ", parentComment=" + parentComment + "]";
	}

}
