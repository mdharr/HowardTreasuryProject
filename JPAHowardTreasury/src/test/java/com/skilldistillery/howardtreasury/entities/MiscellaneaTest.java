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

class MiscellaneaTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Miscellanea miscellanea;

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
		miscellanea = em.find(Miscellanea.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		miscellanea = null;
	}

	@Test
	void test_Miscellanea_entity_mapping() {
		assertNotNull(miscellanea);
		assertEquals("The Black City (fragment)", miscellanea.getTitle());
	}

}
