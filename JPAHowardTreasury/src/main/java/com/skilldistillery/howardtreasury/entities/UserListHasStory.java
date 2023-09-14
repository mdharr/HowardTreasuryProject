package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "user_list_has_story")
public class UserListHasStory {

	@EmbeddedId
	private UserListHasStoryId id;
	
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	@MapsId("userListId")
	private UserList userList;
	
    @ManyToOne
    @JoinColumn(name = "story_id")
    @MapsId("storyId")
    private Story story;

	public UserListHasStory() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasStory(UserListHasStoryId id, UserList userList, Story story) {
		super();
		this.id = new UserListHasStoryId(userList.getId(), story.getId());
		this.userList = userList;
		this.story = story;
	}

	public UserListHasStoryId getId() {
		return id;
	}

	public void setId(UserListHasStoryId id) {
		this.id = id;
	}

	public UserList getUserList() {
		return userList;
	}

	public void setUserList(UserList userList) {
		this.userList = userList;
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
		UserListHasStory other = (UserListHasStory) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "UserListHasStory [id=" + id + ", userList=" + userList + ", story=" + story + "]";
	}
    
}
