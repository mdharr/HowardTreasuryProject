package com.skilldistillery.howardtreasury.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Illustrator {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
    @ManyToMany
    @JoinTable(
    		name = "collection_has_illustrator",
    		joinColumns = @JoinColumn(name = "illustrator_id"),
    		inverseJoinColumns = @JoinColumn(name = "collection_id")
    		)
    private List<Collection> collections;

	public Illustrator() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
