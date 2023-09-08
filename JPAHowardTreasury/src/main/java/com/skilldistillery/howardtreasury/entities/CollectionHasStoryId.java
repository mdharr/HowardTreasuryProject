package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_story")
public class CollectionHasStoryId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "story_id")
    private int storyId;

	public CollectionHasStoryId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasStoryId(int collectionId, int storyId) {
		super();
		this.collectionId = collectionId;
		this.storyId = storyId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, storyId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasStoryId other = (CollectionHasStoryId) obj;
		return collectionId == other.collectionId && storyId == other.storyId;
	}

	@Override
	public String toString() {
		return "CollectionHasStoryId [collectionId=" + collectionId + ", storyId=" + storyId + "]";
	}
    
}
