package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_illustrator")
public class CollectionHasIllustrator {

	@EmbeddedId
	private CollectionHasIllustratorId id;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "illustrator_id")
    @MapsId("illustratorId")
    private Illustrator illustrator;

	public CollectionHasIllustrator() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasIllustrator(CollectionHasIllustratorId id, Collection collection, Illustrator illustrator) {
		super();
		this.id = new CollectionHasIllustratorId(collection.getId(), illustrator.getId());
		this.collection = collection;
		this.illustrator = illustrator;
	}

	public CollectionHasIllustratorId getId() {
		return id;
	}

	public void setId(CollectionHasIllustratorId id) {
		this.id = id;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
	}

	public Illustrator getIllustrator() {
		return illustrator;
	}

	public void setIllustrator(Illustrator illustrator) {
		this.illustrator = illustrator;
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
		CollectionHasIllustrator other = (CollectionHasIllustrator) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasIllustrator [id=" + id + ", collection=" + collection + ", illustrator=" + illustrator
				+ "]";
	}
    
}
