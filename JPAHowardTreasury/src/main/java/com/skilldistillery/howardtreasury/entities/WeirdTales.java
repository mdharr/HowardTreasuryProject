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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "weird_tales")
public class WeirdTales {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String description;
	
	@Column(name = "published_at")
	private LocalDateTime publishedAt;
	
	@Column(name = "page_count")
	private int pageCount;
	
	@Column(name = "thumbnail_url")
	private String thumbnailUrl;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "file_url")
	private String fileUrl;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "weirdTales", cascade = CascadeType.MERGE)
	private List<Story> stories;

	public WeirdTales() {
		super();
	}

	public WeirdTales(int id, String title, String description, LocalDateTime publishedAt, int pageCount,
			String thumbnailUrl, String imageUrl, String fileUrl, List<Story> stories) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.publishedAt = publishedAt;
		this.pageCount = pageCount;
		this.thumbnailUrl = thumbnailUrl;
		this.imageUrl = imageUrl;
		this.fileUrl = fileUrl;
		this.stories = stories;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getPublishedAt() {
		return publishedAt;
	}

	public void setPublishedAt(LocalDateTime publishedAt) {
		this.publishedAt = publishedAt;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public String getThumbnailUrl() {
		return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public List<Story> getStories() {
		return stories;
	}

	public void setStories(List<Story> stories) {
		this.stories = stories;
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
		WeirdTales other = (WeirdTales) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "WeirdTales [id=" + id + ", title=" + title + ", description=" + description + ", publishedAt="
				+ publishedAt + ", pageCount=" + pageCount + ", thumbnailUrl=" + thumbnailUrl + ", imageUrl=" + imageUrl
				+ ", fileUrl=" + fileUrl + "]";
	}
	
}
