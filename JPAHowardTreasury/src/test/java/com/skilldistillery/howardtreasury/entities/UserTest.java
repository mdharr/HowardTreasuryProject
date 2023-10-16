package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	private User user2;

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
		user = em.find(User.class, 1);
		user2 = em.find(User.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
		user2 = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_User_UserList_one_to_many_mapping() {
		assertNotNull(user2);
		assertEquals("King Kull Poems", user2.getUserLists().get(0).getName());
	}
	
	@Test
	void test_User_Illustrator_mapping() {
		assertNotNull(user2);
		assertEquals("Justin Sweet", user2.getUserLists().get(1)
				.getStories().get(0)
				.getCollections().get(0)
				.getIllustrators().get(0)
				.getName());
	}
	
	@Test
	void test_User_ChatMessage_one_to_many_mapping() {
		assertNotNull(user);
		assertEquals("Welcome to the Robert E. Howard Treasury chat room!", user.getChatMessages().get(0).getMessageContent());
	}
	
	@Test
	void test_User_BlogPost_one_to_many_mapping() {
		assertNotNull(user);
		assertEquals("First blog post", user.getBlogPosts().get(0).getTitle());
	}

}
