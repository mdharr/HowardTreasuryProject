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

class PoemTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Poem poem;

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
		poem = em.find(Poem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		poem = null;
	}

	@Test
	void test_Poem_entity_mapping() {
		assertNotNull(poem);
		assertEquals("Am-ra the Ta-an", poem.getTitle());
	}

}
