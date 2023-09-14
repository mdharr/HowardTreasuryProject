package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "user_list_has_story")
public class UserListHasStoryId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_list_id")
	private int userListId;
	
    @Column(name = "story_id")
    private int storyId;

	public UserListHasStoryId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasStoryId(int userListId, int storyId) {
		super();
		this.userListId = userListId;
		this.storyId = storyId;
	}

	public int getUserListId() {
		return userListId;
	}

	public void setUserListId(int userListId) {
		this.userListId = userListId;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(storyId, userListId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserListHasStoryId other = (UserListHasStoryId) obj;
		return storyId == other.storyId && userListId == other.userListId;
	}

	@Override
	public String toString() {
		return "UserListHasStoryId [userListId=" + userListId + ", storyId=" + storyId + "]";
	}
    
}
