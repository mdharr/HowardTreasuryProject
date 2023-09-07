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

class ListContentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ListContent listContent;
	private ListContent listContent2;

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
		listContent = em.find(ListContent.class, 1);
		listContent2 = em.find(ListContent.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		listContent = null;
		listContent2 = null;
	}

	@Test
	void test_ListContent_UserList_many_to_one_mapping() {
		assertNotNull(listContent);
		assertEquals("King Kull Poems", listContent.getUserList().getName());
	}
	
	@Test
	void test_ListContent_Story_many_to_many_mapping() {
		assertNotNull(listContent2);
		assertEquals("The Altar and the Scorpion", listContent2.getStories().get(0).getTitle());
	}

}
