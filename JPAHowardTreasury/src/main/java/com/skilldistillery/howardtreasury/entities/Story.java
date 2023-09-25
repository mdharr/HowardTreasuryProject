package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Story {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	@Column(name = "text_url")
	private String textUrl;
	
	@Column(name = "first_published")
	private LocalDateTime firstPublished;
	
	@Column(name = "alternate_title")
	private String alternateTitle;
	
	@Column(name = "is_copyrighted")
	private Boolean isCopyrighted;
	
	@Column(name = "copyright_expires_at")
	private LocalDateTime copyrightExpiresAt;
	
	private String excerpt;
	
    @JsonIgnore
    @ManyToMany(mappedBy = "stories")
    private List<UserList> userLists;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "stories", cascade = CascadeType.MERGE)
	private List<Collection> collections;

	public Story() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Story(int id, String title, String textUrl, LocalDateTime firstPublished, String alternateTitle,
			Boolean isCopyrighted, LocalDateTime copyrightExpiresAt, String excerpt, List<UserList> userLists,
			List<Collection> collections) {
		super();
		this.id = id;
		this.title = title;
		this.textUrl = textUrl;
		this.firstPublished = firstPublished;
		this.alternateTitle = alternateTitle;
		this.isCopyrighted = isCopyrighted;
		this.copyrightExpiresAt = copyrightExpiresAt;
		this.excerpt = excerpt;
		this.userLists = userLists;
		this.collections = collections;
	}

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

	public String getTextUrl() {
		return textUrl;
	}

	public void setTextUrl(String textUrl) {
		this.textUrl = textUrl;
	}

	public LocalDateTime getFirstPublished() {
		return firstPublished;
	}

	public void setFirstPublished(LocalDateTime firstPublished) {
		this.firstPublished = firstPublished;
	}

	public String getAlternateTitle() {
		return alternateTitle;
	}

	public void setAlternateTitle(String alternateTitle) {
		this.alternateTitle = alternateTitle;
	}

	public Boolean isCopyrighted() {
		return isCopyrighted;
	}

	public void setCopyrighted(Boolean isCopyrighted) {
		this.isCopyrighted = isCopyrighted;
	}

	public LocalDateTime getCopyrightExpiresAt() {
		return copyrightExpiresAt;
	}

	public void setCopyrightExpiresAt(LocalDateTime copyrightExpiresAt) {
		this.copyrightExpiresAt = copyrightExpiresAt;
	}

	public String getExcerpt() {
		return excerpt;
	}

	public void setExcerpt(String excerpt) {
		this.excerpt = excerpt;
	}

	public List<UserList> getUserLists() {
		return userLists;
	}

	public void setUserLists(List<UserList> userLists) {
		this.userLists = userLists;
	}

	public List<Collection> getCollections() {
		return collections;
	}

	public void setCollections(List<Collection> collections) {
		this.collections = collections;
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
		Story other = (Story) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Story [id=" + id + ", title=" + title + ", textUrl=" + textUrl + "]";
	}

}
