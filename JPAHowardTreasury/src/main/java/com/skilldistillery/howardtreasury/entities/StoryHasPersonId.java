package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;

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

}
