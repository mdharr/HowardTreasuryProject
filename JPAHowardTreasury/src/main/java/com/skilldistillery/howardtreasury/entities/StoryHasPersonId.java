package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "story_has_person")
public class StoryHasPersonId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name = "story_id")
	private int storyId;
	
	@Column(name = "person_id")
	private int personId;

	public StoryHasPersonId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasPersonId(int storyId, int personId) {
		super();
		this.storyId = storyId;
		this.personId = personId;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public int getPersonId() {
		return personId;
	}

	public void setPersonId(int personId) {
		this.personId = personId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(personId, storyId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoryHasPersonId other = (StoryHasPersonId) obj;
		return personId == other.personId && storyId == other.storyId;
	}

	@Override
	public String toString() {
		return "StoryHasPersonId [storyId=" + storyId + ", personId=" + personId + "]";
	}

}
