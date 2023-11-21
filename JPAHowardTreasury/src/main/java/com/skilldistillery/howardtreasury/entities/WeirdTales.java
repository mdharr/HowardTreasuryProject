package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "weird_tales")
public class WeirdTales {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
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

	public WeirdTales() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WeirdTales(int id, String name, String description, LocalDateTime publishedAt, int pageCount,
			String thumbnailUrl, String imageUrl, String fileUrl) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.publishedAt = publishedAt;
		this.pageCount = pageCount;
		this.thumbnailUrl = thumbnailUrl;
		this.imageUrl = imageUrl;
		this.fileUrl = fileUrl;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
		return "WeirdTales [id=" + id + ", name=" + name + ", description=" + description + ", publishedAt="
				+ publishedAt + ", pageCount=" + pageCount + ", thumbnailUrl=" + thumbnailUrl + ", imageUrl=" + imageUrl
				+ ", fileUrl=" + fileUrl + "]";
	}
	
}
