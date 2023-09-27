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
@Table(name = "collection_has_poem")
public class CollectionHasPoem {

	@EmbeddedId
	private CollectionHasPoemId id;
	
	@Column(name = "page_number")
	private Integer pageNumber;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "poem_id")
    @MapsId("poemId")
    private Poem poem;

	public CollectionHasPoem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasPoem(CollectionHasPoemId id, Integer pageNumber, Collection collection, Poem poem) {
		super();
		this.id = new CollectionHasPoemId(collection.getId(), poem.getId());
		this.pageNumber = pageNumber;
		this.collection = collection;
		this.poem = poem;
	}

	public CollectionHasPoemId getId() {
		return id;
	}

	public void setId(CollectionHasPoemId id) {
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

	public Poem getPoem() {
		return poem;
	}

	public void setPoem(Poem poem) {
		this.poem = poem;
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
		CollectionHasPoem other = (CollectionHasPoem) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasPoem [id=" + id + ", collection=" + collection + ", poem=" + poem + "]";
	}
    
}
