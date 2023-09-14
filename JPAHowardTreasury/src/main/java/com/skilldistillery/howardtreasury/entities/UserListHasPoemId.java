package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "user_list_has_poem")
public class UserListHasPoemId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_list_id")
	private int userListId;
	
    @Column(name = "poem_id")
    private int poemId;

	public UserListHasPoemId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasPoemId(int userListId, int poemId) {
		super();
		this.userListId = userListId;
		this.poemId = poemId;
	}

	public int getUserListId() {
		return userListId;
	}

	public void setUserListId(int userListId) {
		this.userListId = userListId;
	}

	public int getPoemId() {
		return poemId;
	}

	public void setPoemId(int poemId) {
		this.poemId = poemId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(poemId, userListId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserListHasPoemId other = (UserListHasPoemId) obj;
		return poemId == other.poemId && userListId == other.userListId;
	}

	@Override
	public String toString() {
		return "UserListHasPoemId [userListId=" + userListId + ", poemId=" + poemId + "]";
	}
    
}
