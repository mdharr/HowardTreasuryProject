package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "user_has_chat_room")
public class UserHasChatRoomId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_id")
	private int userId;
	
	@Column(name = "chat_room_id")
	private int chatRoomId;

	public UserHasChatRoomId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserHasChatRoomId(int userId, int chatRoomId) {
		super();
		this.userId = userId;
		this.chatRoomId = chatRoomId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(int chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(chatRoomId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserHasChatRoomId other = (UserHasChatRoomId) obj;
		return chatRoomId == other.chatRoomId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "UserHasChatRoomId [userId=" + userId + ", chatRoomId=" + chatRoomId + "]";
	}
	
}
