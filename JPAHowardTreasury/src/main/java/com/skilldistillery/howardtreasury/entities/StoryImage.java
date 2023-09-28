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
@Table(name = "story_image")
public class StoryImage {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "storyImages", cascade = CascadeType.MERGE)
	private List<Story> stories;
	
	@ManyToMany
	@JoinTable(
			name = "story_image_has_illustrator",
			joinColumns = @JoinColumn(name = "story_image_id"),
			inverseJoinColumns = @JoinColumn(name = "illustrator_id")
			)
	private List<Illustrator> illustrators;

	public StoryImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryImage(int id, String imageUrl, List<Story> stories, List<Illustrator> illustrators) {
		super();
		this.id = id;
		this.imageUrl = imageUrl;
		this.stories = stories;
		this.illustrators = illustrators;
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

	public List<Story> getStories() {
		return stories;
	}

	public List<Illustrator> getIllustrators() {
		return illustrators;
	}

	public void setIllustrators(List<Illustrator> illustrators) {
		this.illustrators = illustrators;
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
		StoryImage other = (StoryImage) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "StoryImage [id=" + id + ", imageUrl=" + imageUrl + "]";
	}
	
}
