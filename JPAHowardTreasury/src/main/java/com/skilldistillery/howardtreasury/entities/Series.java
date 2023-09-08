package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Series {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	@OneToMany(mappedBy = "series")
	private List<Collection> collections;

	public Series() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Series(int id, String title, List<Collection> collections) {
		super();
		this.id = id;
		this.title = title;
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
		Series other = (Series) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Series [id=" + id + ", title=" + title + ", collections=" + collections + "]";
	}
	
}
