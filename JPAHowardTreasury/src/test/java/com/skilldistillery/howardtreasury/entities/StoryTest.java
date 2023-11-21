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
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		story = null;
		story2 = null;
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
	
//	@Test
//	void test_Story_CollectionHasStory_one_to_many_mapping() {
//		assertNotNull(story);
//		assertEquals(133, story.getCollectionHasStories().get(0).getPageNumber());
//	}

}
