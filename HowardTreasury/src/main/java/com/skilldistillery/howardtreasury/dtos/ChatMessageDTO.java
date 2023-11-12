package com.skilldistillery.howardtreasury.dtos;

import java.time.LocalDateTime;
import java.util.Objects;

public class ChatMessageDTO {
    private int id;
    private String messageContent;
    private LocalDateTime createdAt;
    private int chatRoomId;
    private SimpleUserDTO user;

    // Constructors, getters, and setters

    public ChatMessageDTO() {}

    public ChatMessageDTO(int id, String messageContent, LocalDateTime createdAt, int chatRoomId, SimpleUserDTO user) {
        this.id = id;
        this.messageContent = messageContent;
        this.createdAt = createdAt;
        this.chatRoomId = chatRoomId;
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

	public int getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(int chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	public SimpleUserDTO getUser() {
		return user;
	}

	public void setUser(SimpleUserDTO user) {
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
		ChatMessageDTO other = (ChatMessageDTO) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ChatMessageDTO [id=" + id + ", messageContent=" + messageContent + ", createdAt=" + createdAt
				+ ", chatRoomId=" + chatRoomId + ", user=" + user + "]";
	}
    
}
