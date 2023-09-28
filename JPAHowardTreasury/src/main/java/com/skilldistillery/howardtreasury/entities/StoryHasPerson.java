package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

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
	@JoinColumn(name = "person_id")
	@MapsId("personId")
	private Person person;

	public StoryHasPerson() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasPerson(StoryHasPersonId id, Story story, Person person) {
		super();
		this.id = new StoryHasPersonId(story.getId(), person.getId());
		this.story = story;
		this.person = person;
	}

	public StoryHasPersonId getId() {
		return id;
	}

	public void setId(StoryHasPersonId id) {
		this.id = id;
	}

	public Story getStory() {
		return story;
	}

	public void setStory(Story story) {
		this.story = story;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
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
		StoryHasPerson other = (StoryHasPerson) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "StoryHasPerson [id=" + id + ", story=" + story + ", person=" + person + "]";
	}
	
}
