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

class BlogPostTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BlogPost blogPost;

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
		blogPost = em.find(BlogPost.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		blogPost = null;
	}

	@Test
	void test_BlogPost_entity_mapping() {
		assertNotNull(blogPost);
		assertEquals("First blog post", blogPost.getTitle());
	}

}
