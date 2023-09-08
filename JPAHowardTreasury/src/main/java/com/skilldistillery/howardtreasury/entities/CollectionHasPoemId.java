package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_poem")
public class CollectionHasPoemId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "poem_id")
    private int poemId;

	public CollectionHasPoemId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasPoemId(int collectionId, int poemId) {
		super();
		this.collectionId = collectionId;
		this.poemId = poemId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getPoemId() {
		return poemId;
	}

	public void setPoemId(int poemId) {
		this.poemId = poemId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, poemId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasPoemId other = (CollectionHasPoemId) obj;
		return collectionId == other.collectionId && poemId == other.poemId;
	}

	@Override
	public String toString() {
		return "CollectionHasPoemId [collectionId=" + collectionId + ", poemId=" + poemId + "]";
	}
    
}
