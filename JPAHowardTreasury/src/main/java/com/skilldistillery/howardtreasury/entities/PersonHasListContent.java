package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "person_has_list_content")
public class PersonHasListContent {
	
	@EmbeddedId
	private PersonHasListContentId id;
	
    @ManyToOne
    @JoinColumn(name = "person_id")
    @MapsId("personId")
    private Person person;

    @ManyToOne
    @JoinColumn(name = "list_content_id")
    @MapsId("listContentId")
    private ListContent listContent;

	public PersonHasListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PersonHasListContent(PersonHasListContentId id, Person person, ListContent listContent) {
		super();
		this.id = new PersonHasListContentId(person.getId(), listContent.getId());;
		this.person = person;
		this.listContent = listContent;
	}

	public PersonHasListContentId getId() {
		return id;
	}

	public void setId(PersonHasListContentId id) {
		this.id = id;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public ListContent getListContent() {
		return listContent;
	}

	public void setListContent(ListContent listContent) {
		this.listContent = listContent;
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
		PersonHasListContent other = (PersonHasListContent) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PersonHasListContent [id=" + id + ", person=" + person + ", listContent=" + listContent + "]";
	}
    
}
