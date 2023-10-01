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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Person {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	private String description;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "persons", cascade = CascadeType.MERGE)
	private List<Collection> collections;
	
    @JsonIgnore
	@ManyToMany(mappedBy = "persons", cascade = CascadeType.MERGE)
	private List<Story> stories;
	
    @JsonIgnore
	@ManyToMany(mappedBy = "persons", cascade = CascadeType.MERGE)
	private List<Poem> poems;
	
    @JsonIgnore
	@ManyToMany(mappedBy = "persons", cascade = CascadeType.MERGE)
	private List<Miscellanea> miscellaneas;

	public Person() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Person(int id, String name, List<Collection> collections, List<Story> stories,
			List<Poem> poems, List<Miscellanea> miscellaneas) {
		super();
		this.id = id;
		this.name = name;
		this.collections = collections;
		this.stories = stories;
		this.poems = poems;
		this.miscellaneas = miscellaneas;
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

	public List<Story> getStories() {
		return stories;
	}

	public void setStories(List<Story> stories) {
		this.stories = stories;
	}

	public List<Poem> getPoems() {
		return poems;
	}

	public void setPoems(List<Poem> poems) {
		this.poems = poems;
	}

	public List<Miscellanea> getMiscellaneas() {
		return miscellaneas;
	}

	public void setMiscellaneas(List<Miscellanea> miscellaneas) {
		this.miscellaneas = miscellaneas;
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
		Person other = (Person) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + "]";
	}

}
