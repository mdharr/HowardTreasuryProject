package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

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
	
    @ManyToMany(mappedBy = "collections")
    private List<Story> stories;
    
    @ManyToMany(mappedBy = "collections")
    private List<Poem> poems;
    
    @ManyToMany(mappedBy = "collections")
    private List<Person> persons;
    
    @ManyToMany(mappedBy = "collections")
    private List<Miscellanea> miscellaneas;
    
    @ManyToMany(mappedBy = "collections")
    private List<CollectionImage> collectionImages;
    
    @ManyToMany(mappedBy = "collections")
    private List<Illustrator> illustrators;

	public Collection() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Collection(int id, String title, LocalDateTime publishedAt, Integer pageCount,
			String description, Series series, List<Story> stories,
			List<Poem> poems, List<Person> persons, List<Miscellanea> miscellaneas,
			List<CollectionImage> collectionImages, List<Illustrator> illustrators) {
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
