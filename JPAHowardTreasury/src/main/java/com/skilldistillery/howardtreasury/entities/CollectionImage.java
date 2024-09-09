package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "collection_image")
public class CollectionImage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "thumbnail_url")
	private String thumbnailUrl;
	
	@Column(name = "title_image_url")
	private String titleImageUrl;
	
	@Column(name = "cover_image_url")
	private String coverImageUrl;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "collectionImages", cascade = CascadeType.MERGE)
	private List<Collection> collections;

	public CollectionImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionImage(int id, String imageUrl, String thumbnailUrl, String titleImageUrl, String coverImageUrl, List<Collection> collections) {
		super();
		this.id = id;
		this.imageUrl = imageUrl;
		this.thumbnailUrl = thumbnailUrl;
		this.titleImageUrl = titleImageUrl;
		this.coverImageUrl = coverImageUrl;
		this.collections = collections;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getThumbnailUrl() {
		return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}

	public String getTitleImageUrl() {
		return titleImageUrl;
	}

	public void setTitleImageUrl(String titleImageUrl) {
		this.titleImageUrl = titleImageUrl;
	}

	public String getCoverImageUrl() {
		return coverImageUrl;
	}

	public void setCoverImageUrl(String coverImageUrl) {
		this.coverImageUrl = coverImageUrl;
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
		CollectionImage other = (CollectionImage) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "CollectionImage [id=" + id + ", imageUrl=" + imageUrl + ", collections=" + collections + "]";
	}
    
}
