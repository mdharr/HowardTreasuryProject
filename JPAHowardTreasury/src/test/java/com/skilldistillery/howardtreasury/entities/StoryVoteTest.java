package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StoryVoteTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private StoryVote storyVote;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAHowardTreasury");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		storyVote = em.find(StoryVote.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		storyVote = null;
	}

	@Test
	void test_StoryVote_entity_mapping() {
		assertNotNull(storyVote);
		assertEquals("upvote", storyVote.getVoteType());
	}
	
	@Test
	void test_StoryVote_User_many_to_one_mapping() {
		assertNotNull(storyVote);
		assertEquals("Conan", storyVote.getUser().getUsername());
	}
	
	@Test
	void test_StoryVote_Story_many_to_one_mapping() {
		assertNotNull(storyVote);
		assertEquals("The Tower of the Elephant", storyVote.getStory().getTitle());
	}
	
}
