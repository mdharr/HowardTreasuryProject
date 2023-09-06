package com.skilldistillery.howardtreasury.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "chat_room")
public class ChatRoom {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User owner;
    
    @OneToMany(mappedBy = "chatRoom")
    private List<User> users;
	
	@OneToMany(mappedBy = "chatRoom")
	private List<ChatMessage> chatMessages;

	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatRoom(int id, String name, String description, User owner, List<User> users, List<ChatMessage> chatMessages) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.owner = owner;
		this.users = users;
		this.chatMessages = chatMessages;
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

	public User getOwner() {
		return owner;
	}
	
	public void setOwner(User owner) {
		this.owner = owner;
	}
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<ChatMessage> getChatMessages() {
		return chatMessages;
	}

	public void setChatMessages(List<ChatMessage> chatMessages) {
		this.chatMessages = chatMessages;
	}
	
    // Add a user to the chat room
    public void addUser(User user) {
        if (users == null) {
            users = new ArrayList<>();
        }
        users.add(user);
        user.getChatRooms().add(this); // Bidirectional relationship
    }

    // Remove a user from the chat room
    public void removeUser(User user) {
        if (users != null) {
            users.remove(user);
            user.getChatRooms().remove(this); // Bidirectional relationship
        }
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
		ChatRoom other = (ChatRoom) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ChatRoom [id=" + id + ", name=" + name + ", description=" + description + ", owner=" + owner
				+ ", users=" + users + ", chatMessages=" + chatMessages + "]";
	}

}
