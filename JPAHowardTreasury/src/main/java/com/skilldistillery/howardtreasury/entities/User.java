package com.skilldistillery.howardtreasury.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "profile_description")
	private String profileDescription;
	
	private Boolean deactivated;
	
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
    @OneToMany(mappedBy = "user")
    private List<ChatRoom> chatRooms;
	
    @JsonManagedReference
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private VerificationToken verificationToken;
    
    @JsonManagedReference
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private ResetPasswordToken resetPasswordToken;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnoreProperties({"user", "story"})
    private List<StoryVote> storyVotes;

	public User() {
		super();
	}
	
    public User(int id) {
        this.id = id;
    }
    
    public User(int id, String username) {
    	this.id = id;
    	this.username = username;
    }
	
	public User(int id, String username, String password, Boolean enabled, String role, String email,
			String imageUrl, String profileDescription, Boolean deactivated, List<UserList> userLists, List<BlogPost> blogPosts, List<BlogComment> comments,
			List<ChatMessage> chatMessages, List<ChatRoom> chatRooms, VerificationToken verificationToken, List<StoryVote> storyVotes) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.role = role;
		this.email = email;
		this.imageUrl = imageUrl;
		this.profileDescription = profileDescription;
		this.deactivated = deactivated;
		this.userLists = userLists;
		this.blogPosts = blogPosts;
		this.comments = comments;
		this.chatMessages = chatMessages;
		this.chatRooms = chatRooms;
		this.verificationToken = verificationToken;
		this.storyVotes = storyVotes;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getProfileDescription() {
		return profileDescription;
	}

	public void setProfileDescription(String profileDescription) {
		this.profileDescription = profileDescription;
	}

	public Boolean getDeactivated() {
		return deactivated;
	}

	public void setDeactivated(Boolean deactivated) {
		this.deactivated = deactivated;
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

	public List<ChatRoom> getChatRooms() {
		return chatRooms;
	}

	public void setChatRooms(List<ChatRoom> chatRooms) {
		this.chatRooms = chatRooms;
	}

	public VerificationToken getVerificationToken() {
		return verificationToken;
	}

	public void setVerificationToken(VerificationToken verificationToken) {
		this.verificationToken = verificationToken;
	}

	public ResetPasswordToken getResetPasswordToken() {
		return resetPasswordToken;
	}

	public void setResetPasswordToken(ResetPasswordToken resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}
	
    public List<StoryVote> getStoryVotes() {
        return storyVotes;
    }

    public void setStoryVotes(List<StoryVote> storyVotes) {
        this.storyVotes = storyVotes;
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
