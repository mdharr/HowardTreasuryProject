package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "user_list")
public class UserList {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@JsonBackReference("user-userlists")
	@ManyToOne
    @JoinColumn(name = "user_id")
	private User user;
	
    @ManyToMany
    @JoinTable(
        name = "user_list_has_story",
        joinColumns = @JoinColumn(name = "user_list_id"),
        inverseJoinColumns = @JoinColumn(name = "story_id")
    )
    private List<Story> stories;

    @ManyToMany
    @JoinTable(
        name = "user_list_has_poem",
        joinColumns = @JoinColumn(name = "user_list_id"),
        inverseJoinColumns = @JoinColumn(name = "poem_id")
    )
    private List<Poem> poems;

    @ManyToMany
    @JoinTable(
        name = "user_list_has_miscellanea",
        joinColumns = @JoinColumn(name = "user_list_id"),
        inverseJoinColumns = @JoinColumn(name = "miscellanea_id")
    )
    private List<Miscellanea> miscellaneas;

	public UserList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserList(int id, String name, User user, List<Story> stories,
			        List<Poem> poems, List<Miscellanea> miscellaneas) {
		super();
		this.id = id;
		this.name = name;
		this.user = user;
		this.stories = stories;
		this.poems = poems;
		this.miscellaneas = miscellaneas;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Story> getStories() {
		return stories;
	}

	public void setStories(List<Story> stories) {
		this.stories = stories;
	}

	public List<Poem> getPoems() {
		return poems;
	}

	public void setPoems(List<Poem> poems) {
		this.poems = poems;
	}

	public List<Miscellanea> getMiscellaneas() {
		return miscellaneas;
	}

	public void setMiscellaneas(List<Miscellanea> miscellaneas) {
		this.miscellaneas = miscellaneas;
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
		UserList other = (UserList) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "UserList [id=" + id + ", name=" + name + ", user=" + user + "]";
	}

}
