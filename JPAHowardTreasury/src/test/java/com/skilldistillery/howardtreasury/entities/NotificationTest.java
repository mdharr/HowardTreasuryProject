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

import com.skilldistillery.howardtreasury.enums.NotificationType;

class NotificationTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Notification notification;

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
		notification = em.find(Notification.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		notification = null;
	}

	@Test
	void test_Notification_entity_mapping() {
		assertNotNull(notification);
		assertEquals(NotificationType.ACHIEVEMENT_UNLOCKED, notification.getType());
	}
	
	@Test
	void test_Notification_User_one_to_many_mapping() {
		assertNotNull(notification);
		assertEquals("Conan", notification.getUser().getUsername());
	}

}
