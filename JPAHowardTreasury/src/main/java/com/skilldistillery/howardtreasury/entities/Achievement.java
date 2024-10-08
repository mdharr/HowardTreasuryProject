package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Achievement {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	private int experience;
	
    @OneToMany(mappedBy = "achievement")
    private Set<UserHasAchievement> userAchievements;

	public Achievement() {
		super();
	}

	public Achievement(int id, String name, String description, int experience, Set<UserHasAchievement> userAchievements) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.experience = experience;
		this.userAchievements = userAchievements;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getExperience() {
		return experience;
	}
	
	public void setExperience(int experience) {
		this.experience = experience;
	}

	public Set<UserHasAchievement> getUserAchievements() {
		return userAchievements;
	}

	public void setUserAchievements(Set<UserHasAchievement> userAchievements) {
		this.userAchievements = userAchievements;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Achievement other = (Achievement) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "Achievement [id=" + id + ", name=" + name + ", description=" + description + ", experience=" + experience + "]";
	}
	

}
