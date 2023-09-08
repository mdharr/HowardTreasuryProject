package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Embeddable
@Table(name = "collection_has_miscellanea")
public class CollectionHasMiscellaneaId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "collection_id")
	private int collectionId;
	
    @Column(name = "miscellanea_id")
    private int miscellaneaId;

	public CollectionHasMiscellaneaId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasMiscellaneaId(int collectionId, int miscellaneaId) {
		super();
		this.collectionId = collectionId;
		this.miscellaneaId = miscellaneaId;
	}

	public int getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	public int getMiscellaneaId() {
		return miscellaneaId;
	}

	public void setMiscellaneaId(int miscellaneaId) {
		this.miscellaneaId = miscellaneaId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(collectionId, miscellaneaId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CollectionHasMiscellaneaId other = (CollectionHasMiscellaneaId) obj;
		return collectionId == other.collectionId && miscellaneaId == other.miscellaneaId;
	}

	@Override
	public String toString() {
		return "CollectionHasMiscellaneaId [collectionId=" + collectionId + ", miscellaneaId=" + miscellaneaId + "]";
	}
    
}
