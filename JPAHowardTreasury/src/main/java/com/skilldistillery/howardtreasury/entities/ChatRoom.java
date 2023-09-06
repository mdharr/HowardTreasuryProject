package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "chat_room")
public class ChatRoom {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@OneToMany
	private List<ChatMessage> chatMessages;

	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatRoom(int id, String name, List<ChatMessage> chatMessages) {
		super();
		this.id = id;
		this.name = name;
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

	public List<ChatMessage> getChatMessages() {
		return chatMessages;
	}

	public void setChatMessages(List<ChatMessage> chatMessages) {
		this.chatMessages = chatMessages;
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
		return "ChatRoom [id=" + id + ", name=" + name + ", chatMessages=" + chatMessages + "]";
	}

}
