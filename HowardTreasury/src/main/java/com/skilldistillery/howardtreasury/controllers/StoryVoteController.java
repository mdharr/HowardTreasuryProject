package com.skilldistillery.howardtreasury.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.howardtreasury.dtos.StoryVoteDTO;
import com.skilldistillery.howardtreasury.entities.Story;
import com.skilldistillery.howardtreasury.entities.StoryVote;
import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.services.StoryService;
import com.skilldistillery.howardtreasury.services.StoryVoteService;
import com.skilldistillery.howardtreasury.services.UserService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class StoryVoteController {
	
    @Autowired
    private StoryVoteService storyVoteService;
    
    @Autowired
    private StoryService storyService;
    
    @Autowired
    private UserService userService;

    @GetMapping("votes/users/{userId}")
    public ResponseEntity<List<StoryVote>> getVotesByUserId(@PathVariable int userId) {
        List<StoryVote> votes = storyVoteService.getVotesByUserId(userId);
        return new ResponseEntity<>(votes, HttpStatus.OK);
    }

    @GetMapping("votes/stories/{storyId}")
    public ResponseEntity<List<StoryVote>> getVotesByStoryId(@PathVariable int storyId) {
        List<StoryVote> votes = storyVoteService.getVotesByStoryId(storyId);
        return new ResponseEntity<>(votes, HttpStatus.OK);
    }

    @GetMapping("votes/{userId}/{storyId}")
    public ResponseEntity<StoryVote> getVoteByUserIdAndStoryId(@PathVariable int userId, @PathVariable int storyId) {
        StoryVote vote = storyVoteService.getVoteByUserIdAndStoryId(userId, storyId);
        if (vote != null) {
            return new ResponseEntity<>(vote, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("votes")
    public ResponseEntity<StoryVote> createVote(@RequestBody StoryVoteDTO storyVote) {
        Story story = storyService.find(storyVote.getStoryId());
        if (story == null) {
            return ResponseEntity.badRequest().body(null);
        }

        User user = userService.find(storyVote.getUserId());
        if (user == null) {
            return ResponseEntity.badRequest().body(null);
        }

        StoryVote newStoryVote = new StoryVote();
        newStoryVote.setStory(story);
        newStoryVote.setUser(user);
        newStoryVote.setVoteType(storyVote.getVoteType());

        StoryVote savedStoryVote = storyVoteService.saveVote(newStoryVote);
        return ResponseEntity.ok(savedStoryVote);
    }

    @DeleteMapping("votes/{voteId}")
    public ResponseEntity<Void> deleteVote(@PathVariable int voteId) {
        storyVoteService.deleteVote(voteId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
