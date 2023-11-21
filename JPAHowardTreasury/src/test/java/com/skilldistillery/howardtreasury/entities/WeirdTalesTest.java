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

class WeirdTalesTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private WeirdTales weirdTales;

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
		weirdTales = em.find(WeirdTales.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		weirdTales = null;
	}

	@Test
	void test_WeirdTales_entity_mapping() {
		assertNotNull(weirdTales);
		assertEquals("Weird Tales 1925 July", weirdTales.getTitle());
	}

}
