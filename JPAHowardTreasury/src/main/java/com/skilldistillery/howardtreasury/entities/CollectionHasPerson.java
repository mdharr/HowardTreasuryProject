package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_person")
public class CollectionHasPerson {

	@EmbeddedId
	private CollectionHasPersonId id;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "person_id")
    @MapsId("personId")
    private Person person;

	public CollectionHasPerson() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionHasPerson(CollectionHasPersonId id, Collection collection, Person person) {
		super();
		this.id = new CollectionHasPersonId(collection.getId(), person.getId());
		this.collection = collection;
		this.person = person;
	}

	public CollectionHasPersonId getId() {
		return id;
	}

	public void setId(CollectionHasPersonId id) {
		this.id = id;
	}

	public Collection getCollection() {
		return collection;
	}

	public void setCollection(Collection collection) {
		this.collection = collection;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
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
		CollectionHasPerson other = (CollectionHasPerson) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CollectionHasPerson [id=" + id + ", collection=" + collection + ", person=" + person + "]";
	}
    
}
