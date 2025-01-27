package com.skilldistillery.howardtreasury.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Poem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	@Column(name = "text_url")
	private String textUrl;
	
	private String excerpt;
	
	@JsonIgnore
    @ManyToMany(mappedBy = "poems")
    private List<UserList> userLists;
    
	@JsonIgnore
	@ManyToMany(mappedBy = "poems", cascade = CascadeType.MERGE)
	private List<Collection> collections;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(
			name = "poem_has_person",
			joinColumns = @JoinColumn(name = "poem_id"),
			inverseJoinColumns = @JoinColumn(name = "person_id")
			)
	private List<Person> persons;

	public Poem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Poem(int id, String title) {
	    super();
	    this.id = id;
	    this.title = title;
	    this.collections = new ArrayList<>();
	}

	public Poem(int id, String title, String textUrl, String excerpt,
			List<UserList> userLists, List<Collection> collections, List<Person> persons) {
		super();
		this.id = id;
		this.title = title;
		this.textUrl = textUrl;
		this.excerpt = excerpt;
		this.userLists = userLists;
		this.collections = collections;
		this.persons = persons;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTextUrl() {
		return textUrl;
	}

	public void setTextUrl(String textUrl) {
		this.textUrl = textUrl;
	}

	public String getExcerpt() {
		return excerpt;
	}

	public void setExcerpt(String excerpt) {
		this.excerpt = excerpt;
	}

	public List<UserList> getUserLists() {
		return userLists;
	}

	public void setUserLists(List<UserList> userLists) {
		this.userLists = userLists;
	}

	public List<Collection> getCollections() {
		return collections;
	}

	public void setCollections(List<Collection> collections) {
		this.collections = collections;
	}

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
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
		Poem other = (Poem) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Poem [id=" + id + ", title=" + title + ", textUrl=" + textUrl + "]";
	}
    
}
