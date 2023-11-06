package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

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
	private UserList userList2;

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
		userList2 = em.find(UserList.class, 4);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		userList = null;
		userList2 = null;
	}

	@Test
	void test_UserList_entity_mapping() {
		assertNotNull(userList);
		assertEquals("Favorites", userList.getName());
	}
	
	@Test
	void test_UserList_User_many_to_one_mapping() {
		assertNotNull(userList);
		assertEquals("Conan", userList.getUser().getUsername());
	}
	
	@Test
	void test_UserList_Story_many_to_many_mapping() {
		assertNotNull(userList2);
		assertEquals("The Altar and the Scorpion", userList2.getStories().get(0).getTitle());
	}
	
	@Test
	void test_UserList_many_to_many_mappings() {
		assertNotNull(userList2);
		List<Story> stories = userList2.getStories();
		List<Poem> poems = userList2.getPoems();
		List<Miscellanea> miscellaneas = userList2.getMiscellaneas();
		
		for (Story story : stories) {
			System.out.println(story.getTitle());
		}
		
		for (Poem poem : poems) {
			System.out.println(poem.getTitle());
		}
		
		for (Miscellanea miscellanea : miscellaneas) {
			System.out.println(miscellanea.getTitle());
		}
	}

}
