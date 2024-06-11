package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "story_vote")
public class StoryVote {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "story_id")
	@JsonIgnoreProperties("storyVotes")
	private Story story;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	@JsonIgnoreProperties("storyVotes")
	private User user;
	
	@Column(name = "vote_type")
	private String voteType;

	public StoryVote() {
		super();
	}

	public StoryVote(int id, Story story, User user, String voteType) {
		super();
		this.id = id;
		this.story = story;
		this.user = user;
		this.voteType = voteType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

    public Story getStory() {
        return story;
    }

    public void setStory(Story story) {
        this.story = story;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

	public String getVoteType() {
		return voteType;
	}

	public void setVoteType(String voteType) {
		this.voteType = voteType;
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
		StoryVote other = (StoryVote) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "StoryVote [id=" + id + ", story=" + story + ", user=" + user + ", voteType=" + voteType + "]";
	}
	
}
