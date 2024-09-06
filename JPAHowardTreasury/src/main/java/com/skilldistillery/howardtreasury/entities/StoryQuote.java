package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="story_quote")
public class StoryQuote {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String content;
	
	@ManyToOne
	private Story story;

	public StoryQuote() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryQuote(int id, String content, Story story) {
		super();
		this.id = id;
		this.content = content;
		this.story = story;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Story getStory() {
		return story;
	}

	public void setStory(Story story) {
		this.story = story;
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
		StoryQuote other = (StoryQuote) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "StoryQuote [id=" + id + ", content=" + content + ", story=" + story + "]";
	}
	
}
