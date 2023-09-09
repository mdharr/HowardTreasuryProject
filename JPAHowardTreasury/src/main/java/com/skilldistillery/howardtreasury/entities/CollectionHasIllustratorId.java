package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_illustrator")
public class CollectionHasIllustratorId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "illustrator_id")
    private int illustratorId;

	public CollectionHasIllustratorId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasIllustratorId(int collectionId, int illustratorId) {
		super();
		this.collectionId = collectionId;
		this.illustratorId = illustratorId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getIllustratorId() {
		return illustratorId;
	}

	public void setIllustratorId(int illustratorId) {
		this.illustratorId = illustratorId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, illustratorId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasIllustratorId other = (CollectionHasIllustratorId) obj;
		return collectionId == other.collectionId && illustratorId == other.illustratorId;
	}

	@Override
	public String toString() {
		return "CollectionHasIllustratorId [collectionId=" + collectionId + ", illustratorId=" + illustratorId + "]";
	}
    
}
