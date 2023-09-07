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

class UserListTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private UserList userList;

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
		userList = em.find(UserList.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		userList = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(userList);
		assertEquals("King Kull Poems", userList.getName());
	}
	
	@Test
	void test_User_ChatMessage_one_to_many_mapping() {
		assertNotNull(userList);
		assertEquals("Kull", userList.getUser().getUsername());
	}

}
