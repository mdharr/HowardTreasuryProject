package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_miscellanea")
public class CollectionHasMiscellanea {

	@EmbeddedId
	private CollectionHasMiscellaneaId id;
	
	@Column(name = "page_number")
	private Integer pageNumber;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "miscellanea_id")
    @MapsId("miscellaneaId")
    private Miscellanea miscellanea;

	public CollectionHasMiscellanea() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasMiscellanea(CollectionHasMiscellaneaId id, Integer pageNumber, Collection collection, Miscellanea miscellanea) {
		super();
		this.id = new CollectionHasMiscellaneaId(collection.getId(), miscellanea.getId());
		this.pageNumber = pageNumber;
		this.collection = collection;
		this.miscellanea = miscellanea;
	}

	public CollectionHasMiscellaneaId getId() {
		return id;
	}

	public void setId(CollectionHasMiscellaneaId id) {
		this.id = id;
	}

	public Integer getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
	}

	public Miscellanea getMiscellanea() {
		return miscellanea;
	}

	public void setMiscellanea(Miscellanea miscellanea) {
		this.miscellanea = miscellanea;
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
		CollectionHasMiscellanea other = (CollectionHasMiscellanea) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasMiscellanea [id=" + id + ", collection=" + collection + ", miscellanea=" + miscellanea
				+ "]";
	}
    
}
