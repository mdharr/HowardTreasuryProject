package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "user_has_chat_room")
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
	
	@CreationTimestamp
	@Column(name = "joined_at")
	private LocalDateTime joinedAt;
	
	@UpdateTimestamp
	@Column(name = "last_activity")
	private LocalDateTime lastActivity;
	
	@Column(name = "notification_preferences")
	private String notificationPreferences;
	
	@Column(name = "unread_message_count")
	private Integer unreadMessageCount;
	
	@Column(name = "user_status")
	private String userStatus;
	
	private String role;

	public UserHasChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserHasChatRoom(UserHasChatRoomId id, User user, ChatRoom chatRoom, LocalDateTime joinedAt,
			LocalDateTime lastActivity, String notificationPreferences, Integer unreadMessageCount, String userStatus,
			String role) {
		super();
		this.id = new UserHasChatRoomId(user.getId(), chatRoom.getId());
		this.user = user;
		this.chatRoom = chatRoom;
		this.joinedAt = joinedAt;
		this.lastActivity = lastActivity;
		this.notificationPreferences = notificationPreferences;
		this.unreadMessageCount = unreadMessageCount;
		this.userStatus = userStatus;
		this.role = role;
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

	public LocalDateTime getJoinedAt() {
		return joinedAt;
	}

	public void setJoinedAt(LocalDateTime joinedAt) {
		this.joinedAt = joinedAt;
	}

	public LocalDateTime getLastActivity() {
		return lastActivity;
	}

	public void setLastActivity(LocalDateTime lastActivity) {
		this.lastActivity = lastActivity;
	}

	public String getNotificationPreferences() {
		return notificationPreferences;
	}

	public void setNotificationPreferences(String notificationPreferences) {
		this.notificationPreferences = notificationPreferences;
	}

	public Integer getUnreadMessageCount() {
		return unreadMessageCount;
	}

	public void setUnreadMessageCount(Integer unreadMessageCount) {
		this.unreadMessageCount = unreadMessageCount;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
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
