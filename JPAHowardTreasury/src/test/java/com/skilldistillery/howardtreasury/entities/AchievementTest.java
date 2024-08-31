package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class AchievementTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Achievement achievement;

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
		achievement = em.find(Achievement.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		achievement = null;
	}

	@Test
	void test_Achievement_entity_mapping() {
		assertNotNull(achievement);
		assertEquals("Voice of the Hyborian Age", achievement.getName());
	}
	
	@Test
	void test_Achievement_User_many_to_many_mapping() {
		// previous way
//		assertNotNull(achievement);
//		assertTrue(achievement.getUserAchievements().size() > 0);
//		assertEquals("Conan", achievement.getUserAchievements().iterator().next().getUser().getUsername());
		
		// robust way
	    assertNotNull(achievement);
	    
	    Optional<UserHasAchievement> firstUserAchievement = achievement.getUserAchievements().stream().findFirst();
	    
	    assertTrue(firstUserAchievement.isPresent(), "There should be at least one UserHasAchievement");
	    
	    firstUserAchievement.ifPresent(userAchievement -> {
	        User user = userAchievement.getUser();
	        assertNotNull(user, "User should not be null");
	        assertEquals("Conan", user.getUsername(), "Username should be 'Conan'");	        
	    });
	    
	    // If you want to test the case where no UserHasAchievement is present
	    if (!firstUserAchievement.isPresent()) {
	        fail("There should be at least one UserHasAchievement");
	    }
	}

}
