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

class BlogTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Blog blog;

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
		blog = em.find(Blog.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		blog = null;
	}

	@Test
	void test_Blog_entity_mapping() {
		assertNotNull(blog);
		assertEquals("Sword and Sorcery", blog.getTitle());
	}
	
	@Test
	void test_Blog_BlogPost_many_to_many_mapping() {
		assertNotNull(blog);
		assertEquals("First blog post", blog.getBlogPosts().get(0).getTitle());
	}

}
