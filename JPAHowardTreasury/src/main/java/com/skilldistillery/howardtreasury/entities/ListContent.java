package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "list_content")
public class ListContent {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	private UserList userList;

	public ListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ListContent(int id, UserList userList) {
		super();
		this.id = id;
		this.userList = userList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserList getUserList() {
		return userList;
	}

	public void setUserList(UserList userList) {
		this.userList = userList;
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
		ListContent other = (ListContent) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ListContent [id=" + id + ", userList=" + userList + "]";
	}
	
}
