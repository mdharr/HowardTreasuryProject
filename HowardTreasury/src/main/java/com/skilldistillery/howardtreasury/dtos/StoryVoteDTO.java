package com.skilldistillery.howardtreasury.dtos;

import java.util.Objects;

public class StoryVoteDTO {
    private Integer storyId;
    private Integer userId;
    private String voteType;

	public StoryVoteDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryVoteDTO(Integer storyId, Integer userId, String voteType) {
		super();
		this.storyId = storyId;
		this.userId = userId;
		this.voteType = voteType;
	}

	public Integer getStoryId() {
		return storyId;
	}

	public void setStoryId(Integer storyId) {
		this.storyId = storyId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getVoteType() {
		return voteType;
	}

	public void setVoteType(String voteType) {
		this.voteType = voteType;
	}

	@Override
	public int hashCode() {
		return Objects.hash(storyId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoryVoteDTO other = (StoryVoteDTO) obj;
		return Objects.equals(storyId, other.storyId) && Objects.equals(userId, other.userId);
	}

	@Override
	public String toString() {
		return "StoryVoteDTO [storyId=" + storyId + ", userId=" + userId + ", voteType=" + voteType + "]";
	}
    
}
