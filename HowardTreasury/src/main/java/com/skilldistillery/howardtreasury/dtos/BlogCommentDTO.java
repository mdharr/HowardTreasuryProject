package com.skilldistillery.howardtreasury.dtos;

import java.time.LocalDateTime;
import java.util.List;

public class BlogCommentDTO {
    private int id;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UserDTO user;
    private Boolean hidden;
    private BlogCommentDTO parentComment;
    private List<BlogCommentDTO> replies;

    public BlogCommentDTO() {
    }

    public BlogCommentDTO(int id, String content, LocalDateTime createdAt, LocalDateTime updatedAt, UserDTO user, Boolean hidden, BlogCommentDTO parentComment, List<BlogCommentDTO> replies) {
        this.id = id;
        this.content = content;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.user = user;
        this.hidden = hidden;
        this.parentComment = parentComment;
        this.replies = replies;
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

	public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
    
    public BlogCommentDTO getParentComment() {
		return parentComment;
	}

	public void setParentComment(BlogCommentDTO parentComment) {
		this.parentComment = parentComment;
	}

	public List<BlogCommentDTO> getReplies() {
		return replies;
	}

	public void setReplies(List<BlogCommentDTO> replies) {
		this.replies = replies;
	}

	public Boolean getHidden() {
        return hidden;
    }

    public void setHidden(Boolean hidden) {
        this.hidden = hidden;
    }
}
