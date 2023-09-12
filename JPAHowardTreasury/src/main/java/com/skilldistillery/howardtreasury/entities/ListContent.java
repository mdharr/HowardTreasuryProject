package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "list_content")
public class ListContent {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	private UserList userList;
	
	@JsonManagedReference
    @ManyToMany(mappedBy = "listContents")
    private List<Story> stories;
    
	@JsonManagedReference
    @ManyToMany(mappedBy = "listContents")
    private List<Poem> poems;
    
	@JsonManagedReference
    @ManyToMany(mappedBy = "listContents")
    private List<Person> persons;
    
	@JsonManagedReference
    @ManyToMany(mappedBy = "listContents")
    private List<Miscellanea> miscellaneas;

	public ListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ListContent(int id, UserList userList, List<Story> stories) {
		super();
		this.id = id;
		this.userList = userList;
		this.stories = stories;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserList getUserList() {
		return userList;
	}

	public void setUserList(UserList userList) {
		this.userList = userList;
	}

	public List<Story> getStories() {
		return stories;
	}

	public void setStories(List<Story> stories) {
		this.stories = stories;
	}

	public List<Poem> getPoems() {
		return poems;
	}

	public void setPoems(List<Poem> poems) {
		this.poems = poems;
	}

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}

	public List<Miscellanea> getMiscellaneas() {
		return miscellaneas;
	}

	public void setMiscellaneas(List<Miscellanea> miscellaneas) {
		this.miscellaneas = miscellaneas;
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
		ListContent other = (ListContent) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ListContent [id=" + id + ", userList=" + userList + "]";
	}
	
}
