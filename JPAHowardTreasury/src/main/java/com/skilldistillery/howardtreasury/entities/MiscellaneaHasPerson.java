package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "miscellanea_has_person")
public class MiscellaneaHasPerson {

	@EmbeddedId
	private MiscellaneaHasPersonId id;
	
	@ManyToOne
	@JoinColumn(name = "miscellanea_id")
	@MapsId("miscellaneaId")
	private Miscellanea miscellanea;
	
    @ManyToOne
    @JoinColumn(name = "person_id")
    @MapsId("personId")
    private Person person;

	public MiscellaneaHasPerson() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MiscellaneaHasPerson(MiscellaneaHasPersonId id, Miscellanea miscellanea, Person person) {
		super();
		this.id = new MiscellaneaHasPersonId(miscellanea.getId(), person.getId());
		this.miscellanea = miscellanea;
		this.person = person;
	}

	public MiscellaneaHasPersonId getId() {
		return id;
	}

	public void setId(MiscellaneaHasPersonId id) {
		this.id = id;
	}

	public Miscellanea getMiscellanea() {
		return miscellanea;
	}

	public void setMiscellanea(Miscellanea miscellanea) {
		this.miscellanea = miscellanea;
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
		MiscellaneaHasPerson other = (MiscellaneaHasPerson) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "MiscellaneaHasPerson [id=" + id + ", miscellanea=" + miscellanea + ", person=" + person + "]";
	}
    
}
