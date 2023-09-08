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

class CollectionImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private CollectionImage collectionImage;

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
		collectionImage = em.find(CollectionImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		collectionImage = null;
	}

	@Test
	void test_CollectionImage_entity_mapping() {
		assertNotNull(collectionImage);
		assertEquals("https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-coming-of-conan-the-cimmerian.png", collectionImage.getImageUrl());
	}
	
	@Test
	void test_CollectionImage_Collection_many_to_many_mapping() {
		assertNotNull(collectionImage);
		assertEquals("The Coming of Conan the Cimmerian", collectionImage.getCollections().get(0).getTitle());
	}

}
