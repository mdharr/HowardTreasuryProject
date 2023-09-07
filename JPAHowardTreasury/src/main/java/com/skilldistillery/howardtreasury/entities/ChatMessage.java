package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "chat_message")
public class ChatMessage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "message_content")
	private String messageContent;
	
	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "chat_room_id")
	private ChatRoom chatRoom;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public ChatMessage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatMessage(int id, String messageContent, LocalDateTime createdAt, ChatRoom chatRoom, User user) {
		super();
		this.id = id;
		this.messageContent = messageContent;
		this.createdAt = createdAt;
		this.chatRoom = chatRoom;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public ChatRoom getChatRoom() {
		return chatRoom;
	}

	public void setChatRoom(ChatRoom chatRoom) {
		this.chatRoom = chatRoom;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
		ChatMessage other = (ChatMessage) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ChatMessage [id=" + id + ", messageContent=" + messageContent + ", createdAt=" + createdAt
				+ ", chatRoom=" + chatRoom + ", user=" + user + "]";
	}
	
}
