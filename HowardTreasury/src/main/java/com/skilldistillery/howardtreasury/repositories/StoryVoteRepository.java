package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.StoryVote;

public interface StoryVoteRepository extends JpaRepository<StoryVote, Integer> {
    List<StoryVote> findByUserId(int userId);
    List<StoryVote> findByStoryId(int storyId);
    StoryVote findByUserIdAndStoryId(int userId, int storyId);
}
