package com.skilldistillery.howardtreasury.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "story_has_person")
public class StoryHasPerson {

	@EmbeddedId
	private StoryHasPersonId id;
	
	@ManyToOne
	@JoinColumn(name = "story_id")
	@MapsId("storyId")
	private Story story;
	
	@ManyToOne
	@JoinColumn("person_id")
	@MapsId("personId")
	private Person person;
}
