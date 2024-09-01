package com.skilldistillery.howardtreasury.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.howardtreasury.enums.NotificationType;

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
		assertEquals("Conan", user.getUsername());
	}
	
	@Test
	void test_User_UserList_one_to_many_mapping() {
		assertNotNull(user2);
		assertEquals("Favorites", user2.getUserLists().get(0).getName());
	}
	
	@Test
	void test_User_ChatMessage_one_to_many_mapping() {
		assertNotNull(user);
		assertEquals("Welcome to the Robert E. Howard Treasury chat room!", user.getChatMessages().get(0).getMessageContent());
	}
	
	@Test
	void test_User_BlogPost_one_to_many_mapping() {
		assertNotNull(user);
		assertEquals("My Favorite Solomon Kane Tale: “Wings in the Night” by Robert E. Howard", user.getBlogPosts().get(0).getTitle());
	}
	
	@Test
	void test_StoryVote_entity_mapping() {
		assertNotNull(user);
		assertEquals("upvote", user.getStoryVotes().get(0).getVoteType());
	}
	
	@Test
	void test_User_StoryVote_one_to_many_mapping() {
		assertNotNull(user);
		assertEquals("Conan", user.getStoryVotes().get(0).getUser().getUsername());
	}
	
	@Test
	void test_User_Story_many_to_many_mapping() {
		assertNotNull(user);
		assertEquals("The Tower of the Elephant", user.getStoryVotes().get(0).getStory().getTitle());
	}
	
	@Test
	void test_User_Achievement_many_to_many_mapping() {
		
	    assertNotNull(user);
	    
	    Optional<UserHasAchievement> firstUserAchievement = user.getUserAchievements().stream().findFirst();
	    
	    assertTrue(firstUserAchievement.isPresent(), "There should be at least one UserHasAchievement");
	    
	    firstUserAchievement.ifPresent(userAchievement -> {
	        Achievement achievement = userAchievement.getAchievement();
	        assertNotNull(achievement, "Achievement should not be null");
	        assertEquals("Voice of the Hyborian Age", achievement.getName(), "Achievement name should be 'Scribe of Cimmeria'");	        
	    });
	    
	    if (!firstUserAchievement.isPresent()) {
	        fail("There should be at least one UserHasAchievement");
	    }
	}
	
	@Test
	void test_User_Notification_one_to_many_mapping() {
		assertNotNull(user);
		assertTrue(user.getNotifications().size() > 0);
		assertEquals(NotificationType.ACHIEVEMENT_UNLOCKED, user.getNotifications().get(0).getType());
	}

}
