package com.skilldistillery.howardtreasury.dtos;

import java.time.LocalDateTime;
import java.util.List;

public class BlogPostDTO {
    private int id;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private UserDTO user;
    private List<BlogCommentDTO> comments;
    private Boolean hidden;

    public BlogPostDTO() {
        // Default constructor
    }

    public BlogPostDTO(int id, String title, String content, LocalDateTime createdAt, UserDTO user, List<BlogCommentDTO> comments, Boolean hidden) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.user = user;
        this.comments = comments;
        this.hidden = hidden;
    }

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public List<BlogCommentDTO> getComments() {
        return comments;
    }

    public void setComments(List<BlogCommentDTO> comments) {
        this.comments = comments;
    }

    public Boolean getHidden() {
        return hidden;
    }

    public void setHidden(Boolean hidden) {
        this.hidden = hidden;
    }
}
