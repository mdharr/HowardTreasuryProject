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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Collection {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	@Column(name = "published_at")
	private LocalDateTime publishedAt;
	
	@Column(name = "page_count")
	private Integer pageCount;
	
	private String description;
	
	@ManyToOne
	@JoinColumn(name = "series_id")
	private Series series;
	
	@ManyToMany
	@JoinTable(
			name = "collection_has_story",
			joinColumns = @JoinColumn(name = "collection_id"),
			inverseJoinColumns = @JoinColumn(name = "story_id")
			)
	private List<Story> stories;
	
	@JsonBackReference("collection-poems")
	@ManyToMany
	@JoinTable(
			name = "collection_has_poem",
			joinColumns = @JoinColumn(name = "collection_id"),
			inverseJoinColumns = @JoinColumn(name = "poem_id")
			)
	private List<Poem> poems;
	
	@JsonBackReference("collection-persons")
	@ManyToMany
	@JoinTable(
			name = "collection_has_person",
			joinColumns = @JoinColumn(name = "collection_id"),
			inverseJoinColumns = @JoinColumn(name = "person_id")
			)
	private List<Person> persons;
	
	@JsonBackReference("collection-miscellaneas")
	@ManyToMany
	@JoinTable(
			name = "collection_has_miscellanea",
			joinColumns = @JoinColumn(name = "collection_id"),
			inverseJoinColumns = @JoinColumn(name = "miscellanea_id")
			)
	private List<Miscellanea> miscellaneas;
	
	@ManyToMany
	@JoinTable(
			name = "collection_has_collection_image",
			joinColumns = @JoinColumn(name = "collection_id"),
			inverseJoinColumns = @JoinColumn(name = "collection_image_id")
			)
	private List<CollectionImage> collectionImages;
    
    @ManyToMany
    @JoinTable(
        name = "collection_has_illustrator",
        joinColumns = @JoinColumn(name = "collection_id"),
        inverseJoinColumns = @JoinColumn(name = "illustrator_id")
    )
    private List<Illustrator> illustrators;
    
    @JsonIgnore
    @OneToMany(mappedBy = "collection", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<CollectionHasStory> collectionHasStories;

	public Collection() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Collection(int id, String title, LocalDateTime publishedAt, Integer pageCount,
			String description, Series series, List<Story> stories,
			List<Poem> poems, List<Person> persons, List<Miscellanea> miscellaneas,
			List<CollectionImage> collectionImages, List<Illustrator> illustrators,
			List<CollectionHasStory> collectionHasStories) {
		super();
		this.id = id;
		this.title = title;
		this.publishedAt = publishedAt;
		this.pageCount = pageCount;
		this.description = description;
		this.series = series;
		this.stories = stories;
		this.poems = poems;
		this.persons = persons;
		this.miscellaneas = miscellaneas;
		this.collectionImages = collectionImages;
		this.illustrators = illustrators;
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

	public LocalDateTime getPublishedAt() {
		return publishedAt;
	}

	public void setPublishedAt(LocalDateTime publishedAt) {
		this.publishedAt = publishedAt;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Series getSeries() {
		return series;
	}

	public void setSeries(Series series) {
		this.series = series;
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

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}

	public List<Miscellanea> getMiscellaneas() {
		return miscellaneas;
	}

	public void setMiscellaneas(List<Miscellanea> miscellaneas) {
		this.miscellaneas = miscellaneas;
	}

	public List<CollectionImage> getCollectionImages() {
		return collectionImages;
	}

	public void setCollectionImages(List<CollectionImage> collectionImages) {
		this.collectionImages = collectionImages;
	}

	public List<Illustrator> getIllustrators() {
		return illustrators;
	}

	public void setIllustrators(List<Illustrator> illustrators) {
		this.illustrators = illustrators;
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
		Collection other = (Collection) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Collection [id=" + id + ", title=" + title + ", publishedAt=" + publishedAt + ", series=" + series
				+ ", stories=" + stories + ", poems=" + poems + ", persons=" + persons + ", miscellaneas="
				+ miscellaneas + "]";
	}
    
}
