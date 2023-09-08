package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_person")
public class CollectionHasPersonId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "person_id")
    private int personId;

	public CollectionHasPersonId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasPersonId(int collectionId, int personId) {
		super();
		this.collectionId = collectionId;
		this.personId = personId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getPersonId() {
		return personId;
	}

	public void setPersonId(int personId) {
		this.personId = personId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, personId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasPersonId other = (CollectionHasPersonId) obj;
		return collectionId == other.collectionId && personId == other.personId;
	}

	@Override
	public String toString() {
		return "CollectionHasPersonId [collectionId=" + collectionId + ", personId=" + personId + "]";
	}
    
}
