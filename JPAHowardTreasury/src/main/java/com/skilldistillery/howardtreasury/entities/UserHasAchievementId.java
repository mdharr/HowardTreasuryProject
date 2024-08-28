package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class UserHasAchievementId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "achievement_id")
    private Integer achievementId;

	public UserHasAchievementId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserHasAchievementId(Integer userId, Integer achievementId) {
		super();
		this.userId = userId;
		this.achievementId = achievementId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getAchievementId() {
		return achievementId;
	}

	public void setAchievementId(Integer achievementId) {
		this.achievementId = achievementId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(achievementId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserHasAchievementId other = (UserHasAchievementId) obj;
		return Objects.equals(achievementId, other.achievementId) && Objects.equals(userId, other.userId);
	}

	@Override
	public String toString() {
		return "UserHasAchievementId [userId=" + userId + ", achievementId=" + achievementId + "]";
	}

}
