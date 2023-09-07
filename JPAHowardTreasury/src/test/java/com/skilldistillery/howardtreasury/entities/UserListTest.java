package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
		userList2 = em.find(UserList.class, 2);
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
		assertEquals("King Kull Poems", userList.getName());
	}
	
	@Test
	void test_UserList_ListContent_one_to_many_mapping() {
		assertNotNull(userList);
		assertEquals(1, userList.getListContents().get(0).getId());
	}
	
	@Test
	void test_UserList_User_many_to_one_mapping() {
		assertNotNull(userList);
		assertEquals("Kull", userList.getUser().getUsername());
	}
	
	@Test
	void test_UserList_ListContent_one_to_many_mapping2() {
		assertNotNull(userList2);
		assertTrue(userList2.getListContents().size() > 0);
		List<ListContent> listContents = userList2.getListContents();
		for (ListContent listContent : listContents) {
			System.out.println(listContent);
		}
		System.out.println(userList2);
	}

}
