package com.skilldistillery.howardtreasury.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Collection {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "series_id")
	private Series series;
	
    @ManyToMany(mappedBy = "collections")
    private List<Story> stories;
    
    @ManyToMany(mappedBy = "collections")
    private List<Poem> poems;
    
    @ManyToMany(mappedBy = "collections")
    private List<Person> persons;
    
    @ManyToMany(mappedBy = "collections")
    private List<Miscellanea> miscellaneas;

}
