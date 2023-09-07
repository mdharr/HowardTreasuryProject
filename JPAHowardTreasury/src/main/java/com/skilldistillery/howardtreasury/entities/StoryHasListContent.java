package com.skilldistillery.howardtreasury.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "story_has_list_content")
public class StoryHasListContent {
	
	@EmbeddedId
	private StoryHasListContentId id;
	
    @ManyToOne
    @JoinColumn(name = "story_id")
    @MapsId("storyId")
    private Story story;

    @ManyToOne
    @JoinColumn(name = "list_content_id")
    @MapsId("listContentId")
    private ListContent listContent;

	public StoryHasListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryHasListContent(StoryHasListContentId id, Story story, ListContent listContent) {
		super();
		this.id = new StoryHasListContentId(story.getId(), listContent.getId());
		this.story = story;
		this.listContent = listContent;
	}

}
