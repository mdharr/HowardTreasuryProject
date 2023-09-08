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

class CollectionTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Collection collection;

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
		collection = em.find(Collection.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		collection = null;
	}

	@Test
	void test_Collection_entity_mapping() {
		assertNotNull(collection);
		assertEquals("The Coming of Conan the Cimmerian", collection.getTitle());
	}
	
	@Test
	void test_Collection_Story_many_to_many_mapping() {
		assertNotNull(collection);
		assertEquals("Black Colossus", collection.getStories().get(0).getTitle());
	}
	
	@Test
	void test_Collection_Poem_many_to_many_mapping() {
		assertNotNull(collection);
		assertEquals("Cimmeria", collection.getPoems().get(0).getTitle());
	}
	
	@Test
	void test_Collection_Person_many_to_many_mapping() {
		assertNotNull(collection);
		assertEquals("Conan", collection.getPersons().get(0).getName());
	}
	
	@Test
	void test_Collection_Miscellanea_many_to_many_mapping() {
		assertNotNull(collection);
		assertEquals("The Hyborian Age (essay)", collection.getMiscellaneas().get(0).getTitle());
	}


}
