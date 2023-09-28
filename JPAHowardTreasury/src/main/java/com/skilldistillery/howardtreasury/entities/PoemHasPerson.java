package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "poem_has_person")
public class PoemHasPerson {
	
	@EmbeddedId
	private PoemHasPersonId id;
	
	@ManyToOne
	@JoinColumn(name = "poem_id")
	@MapsId("poemId")
	private Poem poem;
	
    @ManyToOne
    @JoinColumn(name = "person_id")
    @MapsId("personId")
    private Person person;

	public PoemHasPerson() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PoemHasPerson(PoemHasPersonId id, Poem poem, Person person) {
		super();
		this.id = new PoemHasPersonId(poem.getId(), person.getId());
		this.poem = poem;
		this.person = person;
	}

	public PoemHasPersonId getId() {
		return id;
	}

	public void setId(PoemHasPersonId id) {
		this.id = id;
	}

	public Poem getPoem() {
		return poem;
	}

	public void setPoem(Poem poem) {
		this.poem = poem;
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
		PoemHasPerson other = (PoemHasPerson) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PoemHasPerson [id=" + id + ", poem=" + poem + ", person=" + person + "]";
	}

}
