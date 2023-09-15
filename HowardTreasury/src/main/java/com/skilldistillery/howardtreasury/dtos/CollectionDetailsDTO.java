package com.skilldistillery.howardtreasury.dtos;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.CollectionImage;
import com.skilldistillery.howardtreasury.entities.Illustrator;
import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Series;
import com.skilldistillery.howardtreasury.entities.Story;

public class CollectionDetailsDTO {

    private Collection collection;
    private Series series;
    private List<Story> stories;
    private List<Poem> poems;
    private List<Person> persons;
    private List<Miscellanea> miscellaneas;
    private List<Illustrator> illustrators;
    private List<CollectionImage> collectionImages;
	public CollectionDetailsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionDetailsDTO(Collection collection, Series series, List<Story> stories, List<Poem> poems,
			List<Person> persons, List<Miscellanea> miscellaneas, List<Illustrator> illustrators,
			List<CollectionImage> collectionImages) {
		super();
		this.collection = collection;
		this.series = series;
		this.stories = stories;
		this.poems = poems;
		this.persons = persons;
		this.miscellaneas = miscellaneas;
		this.illustrators = illustrators;
		this.collectionImages = collectionImages;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
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

	public List<Illustrator> getIllustrators() {
		return illustrators;
	}

	public void setIllustrators(List<Illustrator> illustrators) {
		this.illustrators = illustrators;
	}

	public List<CollectionImage> getCollectionImages() {
		return collectionImages;
	}

	public void setCollectionImages(List<CollectionImage> collectionImages) {
		this.collectionImages = collectionImages;
	}

	@Override
	public String toString() {
		return "CollectionDetailsDTO [collection=" + collection + ", stories=" + stories + ", poems=" + poems
				+ ", persons=" + persons + ", miscellaneas=" + miscellaneas + "]";
	}
    
}
