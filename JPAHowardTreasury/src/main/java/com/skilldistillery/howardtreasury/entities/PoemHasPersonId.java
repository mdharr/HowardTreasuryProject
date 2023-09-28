package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "poem_has_person")
public class PoemHasPersonId implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Column(name = "poem_id")
	private int poemId;
	
    @Column(name = "person_id")
    private int personId;

	public PoemHasPersonId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PoemHasPersonId(int poemId, int personId) {
		super();
		this.poemId = poemId;
		this.personId = personId;
	}

	public int getPoemId() {
		return poemId;
	}

	public void setPoemId(int poemId) {
		this.poemId = poemId;
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
		return Objects.hash(personId, poemId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PoemHasPersonId other = (PoemHasPersonId) obj;
		return personId == other.personId && poemId == other.poemId;
	}

	@Override
	public String toString() {
		return "PoemHasPersonId [poemId=" + poemId + ", personId=" + personId + "]";
	}
    
}
