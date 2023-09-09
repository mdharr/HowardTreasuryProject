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

class IllustratorTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Illustrator illustrator;

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
		illustrator = em.find(Illustrator.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		illustrator = null;
	}

	@Test
	void test_Illustrator_entity_mapping() {
		assertNotNull(illustrator);
		assertEquals("Mark Schultz", illustrator.getName());
	}
	
	@Test
	void test_Illustrator_Collection_many_to_many_mapping() {
		assertNotNull(illustrator);
		assertEquals("The Coming of Conan the Cimmerian", illustrator.getCollections().get(0).getTitle());
	}

}
