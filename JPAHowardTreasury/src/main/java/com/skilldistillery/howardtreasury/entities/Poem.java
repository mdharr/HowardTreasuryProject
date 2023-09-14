package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Poem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
    @JsonIgnore
    @ManyToMany(mappedBy = "poems")
    private List<UserList> userLists;
    
	@JsonIgnore
	@ManyToMany(mappedBy = "poems", cascade = CascadeType.MERGE)
	private List<Collection> collections;

	public Poem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Poem(int id, String title, List<UserList> userLists, List<Collection> collections) {
		super();
		this.id = id;
		this.title = title;
		this.userLists = userLists;
		this.collections = collections;
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
		return "Poem [id=" + id + ", title=" + title + "]";
	}
    
}
