package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "person_has_list_content")
public class PersonHasListContentId implements Serializable {

	private static final long serialVersionUID = 1L;
	
    @Column(name = "person_id")
    private int personId;
    
    @Column(name = "list_content_id")
    private int listContentId;

	public PersonHasListContentId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PersonHasListContentId(int personId, int listContentId) {
		super();
		this.personId = personId;
		this.listContentId = listContentId;
	}

	public int getPersonId() {
		return personId;
	}

	public void setPersonId(int personId) {
		this.personId = personId;
	}

	public int getListContentId() {
		return listContentId;
	}

	public void setListContentId(int listContentId) {
		this.listContentId = listContentId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(listContentId, personId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PersonHasListContentId other = (PersonHasListContentId) obj;
		return listContentId == other.listContentId && personId == other.personId;
	}

	@Override
	public String toString() {
		return "PersonHasListContentId [personId=" + personId + ", listContentId=" + listContentId + "]";
	}
    
}
