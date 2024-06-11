package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.StoryVote;

public interface StoryVoteService {
	StoryVote find(int storyVoteId);
    List<StoryVote> getVotesByUserId(int userId);
    List<StoryVote> getVotesByStoryId(int storyId);
    StoryVote getVoteByUserIdAndStoryId(int userId, int storyId);
    StoryVote saveVote(StoryVote storyVote);
    void deleteVote(int voteId);
}
