package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "story_image_has_illustrator")
public class StoryImageHasIllustrator {

	@EmbeddedId
	private StoryImageHasIllustratorId id;
	
	@ManyToOne
	@JoinColumn(name = "story_image_id")
	@MapsId("storyImageId")
	private StoryImage storyImage;
	
	@ManyToOne
	@JoinColumn(name = "illustrator_id")
	@MapsId("illustratorId")
	private Illustrator illustrator;

	public StoryImageHasIllustrator() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryImageHasIllustrator(StoryImageHasIllustratorId id, StoryImage storyImage, Illustrator illustrator) {
		super();
		this.id = new StoryImageHasIllustratorId(storyImage.getId(), illustrator.getId());
		this.storyImage = storyImage;
		this.illustrator = illustrator;
	}

	public StoryImageHasIllustratorId getId() {
		return id;
	}

	public void setId(StoryImageHasIllustratorId id) {
		this.id = id;
	}

	public StoryImage getStoryImage() {
		return storyImage;
	}

	public void setStoryImage(StoryImage storyImage) {
		this.storyImage = storyImage;
	}

	public Illustrator getIllustrator() {
		return illustrator;
	}

	public void setIllustrator(Illustrator illustrator) {
		this.illustrator = illustrator;
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
		StoryImageHasIllustrator other = (StoryImageHasIllustrator) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "StoryImageHasIllustrator [id=" + id + ", storyImage=" + storyImage + ", illustrator=" + illustrator
				+ "]";
	}
	
}
