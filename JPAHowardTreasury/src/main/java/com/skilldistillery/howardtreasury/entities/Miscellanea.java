package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
public class Miscellanea {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	@JsonBackReference
    @ManyToMany
    @JoinTable(
        name = "miscellanea_has_list_content",
        joinColumns = @JoinColumn(name = "miscellanea_id"),
        inverseJoinColumns = @JoinColumn(name = "list_content_id")
    )
    private List<ListContent> listContents;
    
    @JsonBackReference
    @ManyToMany
    @JoinTable(
    		name = "collection_has_miscellanea",
    		joinColumns = @JoinColumn(name = "miscellanea_id"),
    		inverseJoinColumns = @JoinColumn(name = "collection_id")
    		)
    private List<Collection> collections;

	public Miscellanea() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Miscellanea(int id, String title, List<ListContent> listContents, List<Collection> collections) {
		super();
		this.id = id;
		this.title = title;
		this.listContents = listContents;
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

	public List<ListContent> getListContents() {
		return listContents;
	}

	public void setListContents(List<ListContent> listContents) {
		this.listContents = listContents;
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
		Miscellanea other = (Miscellanea) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Miscellanea [id=" + id + ", title=" + title + ", listContents=" + listContents + "]";
	}
    
}
