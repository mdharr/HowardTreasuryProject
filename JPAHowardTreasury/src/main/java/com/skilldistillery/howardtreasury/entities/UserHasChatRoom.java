package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Entity
public class UserHasChatRoom {

	@EmbeddedId
	private UserHasChatRoomId id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "chat_room_id")
	@MapsId(value = "chatRoomId")
	private ChatRoom chatRoom;

	public UserHasChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserHasChatRoom(UserHasChatRoomId id, User user, ChatRoom chatRoom) {
		super();
		this.id = new UserHasChatRoomId(user.getId(), chatRoom.getId());
		this.user = user;
		this.chatRoom = chatRoom;
	}

	public UserHasChatRoomId getId() {
		return id;
	}

	public void setId(UserHasChatRoomId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ChatRoom getChatRoom() {
		return chatRoom;
	}

	public void setChatRoom(ChatRoom chatRoom) {
		this.chatRoom = chatRoom;
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
		UserHasChatRoom other = (UserHasChatRoom) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "UserHasChatRoom [id=" + id + ", user=" + user + ", chatRoom=" + chatRoom + "]";
	}
	
}
