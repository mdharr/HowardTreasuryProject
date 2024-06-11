package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.StoryVote;
import com.skilldistillery.howardtreasury.repositories.StoryVoteRepository;

@Service
public class StoryVoteServiceImpl implements StoryVoteService {

    @Autowired
    private StoryVoteRepository storyVoteRepo;
    
    @Override
    public StoryVote find(int storyVoteId) {
    	Optional<StoryVote> storyVoteOpt = storyVoteRepo.findById(storyVoteId);
    	if (storyVoteOpt.isPresent()) {
    		StoryVote storyVote = storyVoteOpt.get();
    		return storyVote;
    	}
    	return null;
    }

    @Override
    public List<StoryVote> getVotesByUserId(int userId) {
        return storyVoteRepo.findByUserId(userId);
    }

    @Override
    public List<StoryVote> getVotesByStoryId(int storyId) {
        return storyVoteRepo.findByStoryId(storyId);
    }

    @Override
    public StoryVote getVoteByUserIdAndStoryId(int userId, int storyId) {
        return storyVoteRepo.findByUserIdAndStoryId(userId, storyId);
    }

    @Override
    public StoryVote saveVote(StoryVote storyVote) {
        return storyVoteRepo.save(storyVote);
    }

    @Override
    public void deleteVote(int voteId) {
        storyVoteRepo.deleteById(voteId);
    }

}
