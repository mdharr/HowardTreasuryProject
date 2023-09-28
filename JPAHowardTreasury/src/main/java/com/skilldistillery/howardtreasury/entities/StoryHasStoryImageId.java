package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "story_has_story_image_id")
public class StoryHasStoryImageId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name = "story_id")
	private int storyId;
	
    @Column(name = "story_image_id")
    private int storyImageId;

	public StoryHasStoryImageId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasStoryImageId(int storyId, int storyImageId) {
		super();
		this.storyId = storyId;
		this.storyImageId = storyImageId;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public int getStoryImageId() {
		return storyImageId;
	}

	public void setStoryImageId(int storyImageId) {
		this.storyImageId = storyImageId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(storyId, storyImageId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoryHasStoryImageId other = (StoryHasStoryImageId) obj;
		return storyId == other.storyId && storyImageId == other.storyImageId;
	}

	@Override
	public String toString() {
		return "StoryHasStoryImageId [storyId=" + storyId + ", storyImageId=" + storyImageId + "]";
	}

}
