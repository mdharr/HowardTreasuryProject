package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SeriesTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Series series;

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
		series = em.find(Series.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		series = null;
	}

	@Test
	void test_Series_entity_mapping() {
		assertNotNull(series);
		assertEquals("The Barbarian Series", series.getTitle());
	}
	
	@Test
	void test_Series_Collection_one_to_many_mapping() {
		assertNotNull(series);
		assertEquals("The Coming of Conan the Cimmerian", series.getCollections().get(0).getTitle());
	}
	
	@Test
	void test_Series_Illustrator_mapping() {
		assertNotNull(series);
		assertEquals("Mark Schultz", series.getCollections().get(0).getIllustrators().get(0).getName());
	}
	
}
