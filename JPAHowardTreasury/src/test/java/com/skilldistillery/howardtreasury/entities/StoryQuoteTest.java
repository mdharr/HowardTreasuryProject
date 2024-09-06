package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StoryQuoteTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private StoryQuote storyQuote;

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
		storyQuote = em.find(StoryQuote.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		storyQuote = null;
	}

	@Test
	void test_StoryQuote_entity_mapping() {
		assertNotNull(storyQuote);
		assertEquals("He told how murderers walk the earth Beneath the curse of Cain, "
				+ "With crimson clouds before their eyes And flames about their brain: "
				+ "For blood has left upon their souls Its everlasting stain.", storyQuote.getContent());
	}
	
	@Test
	void test_StoryQuote_Story_many_to_one_mapping() {
		assertNotNull(storyQuote);
		assertEquals("Skulls in the Stars", storyQuote.getStory().getTitle());
	}

}
