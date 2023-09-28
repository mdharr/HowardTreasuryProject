package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "story_has_story_image")
public class StoryHasStoryImage {
	
	@EmbeddedId
	private StoryHasStoryImageId id;
	
	@ManyToOne
	@JoinColumn(name = "story_id")
	@MapsId("storyId")
	private Story story;
	
    @ManyToOne
    @JoinColumn(name = "story_image_id")
    @MapsId("storyImageId")
    private StoryImage storyImage;

	public StoryHasStoryImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasStoryImage(StoryHasStoryImageId id, Story story, StoryImage storyImage) {
		super();
		this.id = new StoryHasStoryImageId(story.getId(), storyImage.getId());
		this.story = story;
		this.storyImage = storyImage;
	}

	public StoryHasStoryImageId getId() {
		return id;
	}

	public void setId(StoryHasStoryImageId id) {
		this.id = id;
	}

	public Story getStory() {
		return story;
	}

	public void setStory(Story story) {
		this.story = story;
	}

	public StoryImage getStoryImage() {
		return storyImage;
	}

	public void setStoryImage(StoryImage storyImage) {
		this.storyImage = storyImage;
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
		StoryHasStoryImage other = (StoryHasStoryImage) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "StoryHasStoryImage [id=" + id + ", story=" + story + ", storyImage=" + storyImage + "]";
	}

}
