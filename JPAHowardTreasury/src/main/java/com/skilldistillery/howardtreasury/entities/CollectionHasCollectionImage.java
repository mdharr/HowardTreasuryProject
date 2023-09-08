package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_collection_image")
public class CollectionHasCollectionImage {

	@EmbeddedId
	private CollectionHasCollectionImageId id;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "collection_image_id")
    @MapsId("collectionImageId")
    private CollectionImage collectionImage;

	public CollectionHasCollectionImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasCollectionImage(CollectionHasCollectionImageId id, Collection collection,
			CollectionImage collectionImage) {
		super();
		this.id = new CollectionHasCollectionImageId(collection.getId(), collectionImage.getId());
		this.collection = collection;
		this.collectionImage = collectionImage;
	}

	public CollectionHasCollectionImageId getId() {
		return id;
	}

	public void setId(CollectionHasCollectionImageId id) {
		this.id = id;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
	}

	public CollectionImage getCollectionImage() {
		return collectionImage;
	}

	public void setCollectionImage(CollectionImage collectionImage) {
		this.collectionImage = collectionImage;
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
		CollectionHasCollectionImage other = (CollectionHasCollectionImage) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasCollectionImage [id=" + id + ", collection=" + collection + ", collectionImage="
				+ collectionImage + "]";
	}
    
}
