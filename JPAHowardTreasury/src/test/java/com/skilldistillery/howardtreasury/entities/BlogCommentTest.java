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

class BlogCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BlogComment blogComment;

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
		blogComment = em.find(BlogComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		blogComment = null;
	}

	@Test
	void test_BlogComment_entity_mapping() {
		assertNotNull(blogComment);
		assertEquals("Great first post!", blogComment.getContent());
	}
	
	@Test
	void test_BlogComment_Replies_one_to_many_mapping() {
		assertNotNull(blogComment);
		assertTrue(blogComment.getReplies().size() > 0);
		assertEquals("Great first comment!", blogComment.getReplies().get(0).getContent());
	}

}
