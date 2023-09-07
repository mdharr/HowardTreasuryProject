package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "story_has_list_content")
public class StoryHasListContentId implements Serializable {

	private static final long serialVersionUID = 1L;
	
    @Column(name = "story_id")
    private int storyId;
    
    @Column(name = "list_content_id")
    private int listContentId;

	public StoryHasListContentId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasListContentId(int storyId, int listContentId) {
		super();
		this.storyId = storyId;
		this.listContentId = listContentId;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public int getListContentId() {
		return listContentId;
	}

	public void setListContentId(int listContentId) {
		this.listContentId = listContentId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(listContentId, storyId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoryHasListContentId other = (StoryHasListContentId) obj;
		return listContentId == other.listContentId && storyId == other.storyId;
	}

	@Override
	public String toString() {
		return "StoryHasListContentId [storyId=" + storyId + ", listContentId=" + listContentId + "]";
	}
	
}
