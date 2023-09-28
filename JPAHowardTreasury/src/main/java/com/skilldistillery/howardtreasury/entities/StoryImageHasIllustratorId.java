package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "story_image_has_illustrator")
public class StoryImageHasIllustratorId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name = "story_image_id")
	private int storyImageId;
	
	@Column(name = "illustrator_id")
	private int illustratorId;

	public StoryImageHasIllustratorId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryImageHasIllustratorId(int storyImageId, int illustratorId) {
		super();
		this.storyImageId = storyImageId;
		this.illustratorId = illustratorId;
	}

	public int getStoryImageId() {
		return storyImageId;
	}

	public void setStoryImageId(int storyImageId) {
		this.storyImageId = storyImageId;
	}

	public int getIllustratorId() {
		return illustratorId;
	}

	public void setIllustratorId(int illustratorId) {
		this.illustratorId = illustratorId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(illustratorId, storyImageId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoryImageHasIllustratorId other = (StoryImageHasIllustratorId) obj;
		return illustratorId == other.illustratorId && storyImageId == other.storyImageId;
	}

	@Override
	public String toString() {
		return "StoryImageHasIllustratorId [storyImageId=" + storyImageId + ", illustratorId=" + illustratorId + "]";
	}
	
}
