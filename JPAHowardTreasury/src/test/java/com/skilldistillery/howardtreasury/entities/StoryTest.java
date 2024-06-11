package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StoryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Story story;
	private Story story2;
	private Story story3;

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
		story = em.find(Story.class, 1);
		story2 = em.find(Story.class, 119);
		story3 = em.find(Story.class, 22);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		story = null;
		story2 = null;
		story3 = null;
	}

	@Test
	void test_Story_entity_mapping() {
		assertNotNull(story);
		assertEquals("The Altar and the Scorpion", story.getTitle());
	}
	
	@Test
	void test_Story_WeirdTales_many_to_many_mapping() {
		assertNotNull(story2);
		assertEquals("Weird Tales 1925 July", story2.getWeirdTales().get(0).getTitle());
	}
	
	@Test
	void test_StoryVote_entity_mapping() {
		assertNotNull(story3);
		assertEquals("upvote", story3.getStoryVotes().get(0).getVoteType());
	}
	
	@Test
	void test_Story_User_many_to_many_mapping() {
		assertNotNull(story3);
		assertEquals("Conan", story3.getStoryVotes().get(0).getUser().getUsername());
	}
	
	@Test
	void test_Story_Story_one_to_many_mapping() {
		assertNotNull(story3);
		assertEquals("The Tower of the Elephant", story3.getStoryVotes().get(0).getStory().getTitle());
	}

}
