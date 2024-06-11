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
import org.springframework.web.bind.annotation.PutMapping;
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
    public ResponseEntity<StoryVote> createVote(@RequestBody StoryVoteDTO storyVoteDto) {
        Story story = storyService.find(storyVoteDto.getStoryId());
        if (story == null) {
            return ResponseEntity.badRequest().body(null);
        }

        User user = userService.find(storyVoteDto.getUserId());
        if (user == null) {
            return ResponseEntity.badRequest().body(null);
        }

        StoryVote existingVote = storyVoteService.getVoteByUserIdAndStoryId(user.getId(), story.getId());

        if (existingVote != null) {
            if (existingVote.getVoteType().equals(storyVoteDto.getVoteType())) {
                storyVoteService.deleteVote(existingVote.getId());
                return ResponseEntity.ok(null);
            } else {
                existingVote.setVoteType(storyVoteDto.getVoteType());
                StoryVote updatedVote = storyVoteService.saveVote(existingVote);
                return ResponseEntity.ok(updatedVote);
            }
        } else {
            StoryVote newVote = new StoryVote();
            newVote.setStory(story);
            newVote.setUser(user);
            newVote.setVoteType(storyVoteDto.getVoteType());
            StoryVote savedVote = storyVoteService.saveVote(newVote);
            return ResponseEntity.ok(savedVote);
        }
    }

    @PutMapping("votes/{id}")
    public ResponseEntity<StoryVote> updateVote(@PathVariable int id, @RequestBody StoryVoteDTO storyVote) {
        StoryVote existingVote = storyVoteService.find(id);
        if (existingVote == null) {
            return ResponseEntity.notFound().build();
        }
        
        existingVote.setVoteType(storyVote.getVoteType());
        StoryVote updatedStoryVote = storyVoteService.saveVote(existingVote);
        return ResponseEntity.ok(updatedStoryVote);
    }

    @DeleteMapping("votes/{voteId}")
    public ResponseEntity<Void> deleteVote(@PathVariable int voteId) {
        storyVoteService.deleteVote(voteId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
