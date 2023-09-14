package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "user_list_has_poem")
public class UserListHasPoem {

	@EmbeddedId
	private UserListHasPoemId id;
	
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	@MapsId("userListId")
	private UserList userList;
	
    @ManyToOne
    @JoinColumn(name = "poem_id")
    @MapsId("poemId")
    private Poem poem;

	public UserListHasPoem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasPoem(UserListHasPoemId id, UserList userList, Poem poem) {
		super();
		this.id = new UserListHasPoemId(userList.getId(), poem.getId());
		this.userList = userList;
		this.poem = poem;
	}

	public UserListHasPoemId getId() {
		return id;
	}

	public void setId(UserListHasPoemId id) {
		this.id = id;
	}

	public UserList getUserList() {
		return userList;
	}

	public void setUserList(UserList userList) {
		this.userList = userList;
	}

	public Poem getPoem() {
		return poem;
	}

	public void setPoem(Poem poem) {
		this.poem = poem;
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
		UserListHasPoem other = (UserListHasPoem) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "UserListHasPoem [id=" + id + ", userList=" + userList + ", poem=" + poem + "]";
	}
    
}
