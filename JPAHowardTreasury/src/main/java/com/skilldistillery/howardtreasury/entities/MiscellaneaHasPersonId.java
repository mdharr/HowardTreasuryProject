package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "miscellanea_has_person")
public class MiscellaneaHasPersonId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "miscellanea_id")
	private int miscellaneaId;
	
    @Column(name = "person_id")
    private int personId;

	public MiscellaneaHasPersonId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MiscellaneaHasPersonId(int miscellaneaId, int personId) {
		super();
		this.miscellaneaId = miscellaneaId;
		this.personId = personId;
	}

	public int getMiscellaneaId() {
		return miscellaneaId;
	}

	public void setMiscellaneaId(int miscellaneaId) {
		this.miscellaneaId = miscellaneaId;
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
		return Objects.hash(miscellaneaId, personId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MiscellaneaHasPersonId other = (MiscellaneaHasPersonId) obj;
		return miscellaneaId == other.miscellaneaId && personId == other.personId;
	}

	@Override
	public String toString() {
		return "MiscellaneaHasPersonId [miscellaneaId=" + miscellaneaId + ", personId=" + personId + "]";
	}
    
}
