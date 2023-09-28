package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
	
	private String description;
	
    @JsonIgnore
    @ManyToMany(mappedBy = "stories")
    private List<UserList> userLists;
	
	@JsonIgnoreProperties("stories")
	@ManyToMany(mappedBy = "stories", cascade = CascadeType.MERGE)
	private List<Collection> collections;
	
	@ManyToMany
	@JoinTable(
			name = "story_has_story_image",
			joinColumns = @JoinColumn(name = "story_id"),
			inverseJoinColumns = @JoinColumn(name = "story_image_id")
			)
	private List<StoryImage> storyImages;
	
	@ManyToMany
	@JoinTable(
			name = "story_has_person",
			joinColumns = @JoinColumn(name = "story_id"),
			inverseJoinColumns = @JoinColumn(name = "person_id")
			)
	private List<Person> persons;
	
	@JsonIgnore
	@OneToMany(mappedBy = "story", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<CollectionHasStory> collectionHasStories;

	public Story() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Story(int id, String title, String textUrl, LocalDateTime firstPublished, String alternateTitle,
			Boolean isCopyrighted, LocalDateTime copyrightExpiresAt, String excerpt, String description, 
			List<UserList> userLists, List<Collection> collections, List<StoryImage> storyImages, 
			List<Person> persons, List<CollectionHasStory> collectionHasStories) {
		super();
		this.id = id;
		this.title = title;
		this.textUrl = textUrl;
		this.firstPublished = firstPublished;
		this.alternateTitle = alternateTitle;
		this.isCopyrighted = isCopyrighted;
		this.copyrightExpiresAt = copyrightExpiresAt;
		this.excerpt = excerpt;
		this.description = description;
		this.userLists = userLists;
		this.collections = collections;
		this.storyImages = storyImages;
		this.persons = persons;
		this.collectionHasStories = collectionHasStories;
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

	public Boolean getIsCopyrighted() {
		return isCopyrighted;
	}

	public void setIsCopyrighted(Boolean isCopyrighted) {
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public List<StoryImage> getStoryImages() {
		return storyImages;
	}

	public void setStoryImages(List<StoryImage> storyImages) {
		this.storyImages = storyImages;
	}

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}

	public List<CollectionHasStory> getCollectionHasStories() {
		return collectionHasStories;
	}

	public void setCollectionHasStories(List<CollectionHasStory> collectionHasStories) {
		this.collectionHasStories = collectionHasStories;
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
