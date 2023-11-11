package com.skilldistillery.howardtreasury.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "chat_room")
public class ChatRoom {
	
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private String description;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "chatRoom")
    private List<ChatMessage> chatMessages; // Add this field

	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}
	
    public ChatRoom(int id) {
        this.id = id;
    }

	public ChatRoom(int id, String name, String description, User user, List<ChatMessage> chatMessages) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.user = user;
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

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	public List<ChatMessage> getChatMessages() {
		return chatMessages;
	}

	public void setChatMessages(List<ChatMessage> chatMessages) {
		this.chatMessages = chatMessages;
	}
    
    public void addChatMessage(ChatMessage chatMessage) {
        if (chatMessages == null) {
            chatMessages = new ArrayList<>();
        }
        chatMessages.add(chatMessage);
        chatMessage.setChatRoom(this);
    }

    public void removeChatMessage(ChatMessage chatMessage) {
        if (chatMessages != null) {
            chatMessages.remove(chatMessage);
            chatMessage.setChatRoom(null);
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
		return "ChatRoom [id=" + id + ", name=" + name + ", description=" + description + ", user=" + user
				+ ", chatMessages=" + chatMessages + "]";
	}

}
