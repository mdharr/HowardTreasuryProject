package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_story")
public class CollectionHasStory {

	@EmbeddedId
	private CollectionHasStoryId id;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "story_id")
    @MapsId("storyId")
    private Story story;

	public CollectionHasStory() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasStory(CollectionHasStoryId id, Collection collection, Story story) {
		super();
		this.id = new CollectionHasStoryId(collection.getId(), story.getId());
		this.collection = collection;
		this.story = story;
	}

	public CollectionHasStoryId getId() {
		return id;
	}

	public void setId(CollectionHasStoryId id) {
		this.id = id;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
	}

	public Story getStory() {
		return story;
	}

	public void setStory(Story story) {
		this.story = story;
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
		CollectionHasStory other = (CollectionHasStory) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasStory [id=" + id + ", collection=" + collection + ", story=" + story + "]";
	}
    
}
