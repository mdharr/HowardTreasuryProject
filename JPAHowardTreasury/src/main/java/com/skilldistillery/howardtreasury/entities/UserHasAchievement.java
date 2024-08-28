package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "user_has_achievement")
public class UserHasAchievement {
	
    @EmbeddedId
    private UserHasAchievementId id;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @MapsId("achievementId")
    @JoinColumn(name = "achievement_id")
    private Achievement achievement;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

	public UserHasAchievement() {
		super();
	}

	public UserHasAchievement(UserHasAchievementId id, User user, Achievement achievement, LocalDateTime createdAt) {
		super();
		this.id = new UserHasAchievementId(user.getId(), achievement.getId());
		this.user = user;
		this.achievement = achievement;
		this.createdAt = createdAt;
	}

	public UserHasAchievementId getId() {
		return id;
	}

	public void setId(UserHasAchievementId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Achievement getAchievement() {
		return achievement;
	}

	public void setAchievement(Achievement achievement) {
		this.achievement = achievement;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public int hashCode() {
		return Objects.hash(achievement, user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserHasAchievement other = (UserHasAchievement) obj;
		return Objects.equals(achievement, other.achievement) && Objects.equals(user, other.user);
	}

	@Override
	public String toString() {
		return "UserHasAchievement [user=" + user + ", achievement=" + achievement + ", createdAt=" + createdAt + "]";
	}
    

}
