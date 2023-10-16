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
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	
	private String password;
	
	private Boolean enabled;
	
	private String role;
	
	private String email;
	
	// maybe add a json ignore here or opposite side in userlists
	// can't see lists to add to in frontend ui when using json ignore
	@JsonManagedReference("user-userlists")
	@OneToMany(mappedBy = "user")
	private List<UserList> userLists;
	
	@JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<BlogPost> blogPosts;
    
	@JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<BlogComment> comments;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<ChatMessage> chatMessages;
	
	@JsonIgnore
    @OneToMany(mappedBy = "owner")
    private List<ChatRoom> ownedChatRooms;

	@JsonIgnore
    @ManyToMany
    @JoinTable(
        name = "user_has_chat_room",
        joinColumns = @JoinColumn(name = "user_id"),
        inverseJoinColumns = @JoinColumn(name = "chat_room_id")
    )
    private List<ChatRoom> chatRooms;

	public User() {
		super();
	}
	
	public User(int id, String username, String password, Boolean enabled, String role, String email,
			List<UserList> userLists, List<BlogPost> blogPosts, List<BlogComment> comments,
			List<ChatMessage> chatMessages, List<ChatRoom> ownedChatRooms, List<ChatRoom> chatRooms) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.role = role;
		this.email = email;
		this.userLists = userLists;
		this.blogPosts = blogPosts;
		this.comments = comments;
		this.chatMessages = chatMessages;
		this.ownedChatRooms = ownedChatRooms;
		this.chatRooms = chatRooms;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<UserList> getUserLists() {
		return userLists;
	}

	public void setUserLists(List<UserList> userLists) {
		this.userLists = userLists;
	}

	public List<BlogPost> getBlogPosts() {
		return blogPosts;
	}

	public void setBlogPosts(List<BlogPost> blogPosts) {
		this.blogPosts = blogPosts;
	}

	public List<BlogComment> getComments() {
		return comments;
	}

	public void setComments(List<BlogComment> comments) {
		this.comments = comments;
	}

	public List<ChatMessage> getChatMessages() {
		return chatMessages;
	}

	public void setChatMessages(List<ChatMessage> chatMessages) {
		this.chatMessages = chatMessages;
	}

	public List<ChatRoom> getOwnedChatRooms() {
		return ownedChatRooms;
	}

	public void setOwnedChatRooms(List<ChatRoom> ownedChatRooms) {
		this.ownedChatRooms = ownedChatRooms;
	}

	public List<ChatRoom> getChatRooms() {
		return chatRooms;
	}

	public void setChatRooms(List<ChatRoom> chatRooms) {
		this.chatRooms = chatRooms;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", email=" + email + "]";
	}
	
}
