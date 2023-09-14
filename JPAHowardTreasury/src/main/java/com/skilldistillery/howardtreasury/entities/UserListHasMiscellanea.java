package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "user_list_has_miscellanea")
public class UserListHasMiscellanea {

	@EmbeddedId
	private UserListHasMiscellaneaId id;
	
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	@MapsId("userListId")
	private UserList userList;
	
    @ManyToOne
    @JoinColumn(name = "miscellanea_id")
    @MapsId("miscellaneaId")
    private Miscellanea miscellanea;

	public UserListHasMiscellanea() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasMiscellanea(UserListHasMiscellaneaId id, UserList userList, Miscellanea miscellanea) {
		super();
		this.id = new UserListHasMiscellaneaId(userList.getId(), miscellanea.getId());
		this.userList = userList;
		this.miscellanea = miscellanea;
	}

	public UserListHasMiscellaneaId getId() {
		return id;
	}

	public void setId(UserListHasMiscellaneaId id) {
		this.id = id;
	}

	public UserList getUserList() {
		return userList;
	}

	public void setUserList(UserList userList) {
		this.userList = userList;
	}

	public Miscellanea getMiscellanea() {
		return miscellanea;
	}

	public void setMiscellanea(Miscellanea miscellanea) {
		this.miscellanea = miscellanea;
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
		UserListHasMiscellanea other = (UserListHasMiscellanea) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "UserListHasMiscellanea [id=" + id + ", userList=" + userList + ", miscellanea=" + miscellanea + "]";
	}
    
}
