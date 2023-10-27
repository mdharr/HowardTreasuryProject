package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Illustrator {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	private String description;
	
    @JsonIgnore
	@ManyToMany(mappedBy = "illustrators", cascade = CascadeType.MERGE)
	private List<Collection> collections;
	
    @JsonIgnoreProperties("illustrators")
	@ManyToMany(mappedBy = "illustrators", cascade = CascadeType.MERGE)
	private List<StoryImage> storyImages;


	public Illustrator() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Illustrator(int id, String name, String imageUrl, String description, List<Collection> collections, List<StoryImage> storyImages) {
		super();
		this.id = id;
		this.name = name;
		this.imageUrl = imageUrl;
		this.description = description;
		this.collections = collections;
		this.storyImages = storyImages;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Collection> getCollections() {
		return collections;
	}

	public void setCollections(List<Collection> collections) {
		this.collections = collections;
	}

	public List<StoryImage> getStoryImages() {
		return storyImages;
	}

	public void setStoryImages(List<StoryImage> storyImages) {
		this.storyImages = storyImages;
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
		Illustrator other = (Illustrator) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Illustrator [id=" + id + ", name=" + name + ", collections=" + collections + "]";
	}
	
}
