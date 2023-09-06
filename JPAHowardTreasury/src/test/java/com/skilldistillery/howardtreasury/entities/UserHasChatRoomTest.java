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

class UserHasChatRoomTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private UserHasChatRoom userHasChatRoom;

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
		userHasChatRoom = em.find(UserHasChatRoom.class, new UserHasChatRoomId(1, 1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		userHasChatRoom = null;
	}

	@Test
	void test_UserHasChatRoom_entity_mapping() {
		assertNotNull(userHasChatRoom);
		assertEquals("Public Chat Room", userHasChatRoom.getChatRoom().getName());
	}
	
	@Test
	void test_UserHasChatRoom_ChatRoom_one_to_many_mapping() {
		assertNotNull(userHasChatRoom);
		assertEquals("Welcome to the Robert E. Howard Treasury chat room!", userHasChatRoom.getChatRoom().getChatMessages().get(0).getMessageContent());
	}

}
