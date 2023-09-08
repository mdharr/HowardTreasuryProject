package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_collection_image")
public class CollectionHasCollectionImageId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "collection_image_id")
    private int collectionImageId;

	public CollectionHasCollectionImageId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasCollectionImageId(int collectionId, int collectionImageId) {
		super();
		this.collectionId = collectionId;
		this.collectionImageId = collectionImageId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getCollectionImageId() {
		return collectionImageId;
	}

	public void setCollectionImageId(int collectionImageId) {
		this.collectionImageId = collectionImageId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, collectionImageId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasCollectionImageId other = (CollectionHasCollectionImageId) obj;
		return collectionId == other.collectionId && collectionImageId == other.collectionImageId;
	}

	@Override
	public String toString() {
		return "CollectionHasCollectionImageId [collectionId=" + collectionId + ", collectionImageId="
				+ collectionImageId + "]";
	}
    
}
