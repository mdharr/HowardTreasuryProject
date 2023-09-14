package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "user_list_has_miscellanea")
public class UserListHasMiscellaneaId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_list_id")
	private int userListId;
	
    @Column(name = "miscellanea_id")
    private int miscellaneaId;

	public UserListHasMiscellaneaId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserListHasMiscellaneaId(int userListId, int miscellaneaId) {
		super();
		this.userListId = userListId;
		this.miscellaneaId = miscellaneaId;
	}

	public int getUserListId() {
		return userListId;
	}

	public void setUserListId(int userListId) {
		this.userListId = userListId;
	}

	public int getMiscellaneaId() {
		return miscellaneaId;
	}

	public void setMiscellaneaId(int miscellaneaId) {
		this.miscellaneaId = miscellaneaId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(miscellaneaId, userListId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserListHasMiscellaneaId other = (UserListHasMiscellaneaId) obj;
		return miscellaneaId == other.miscellaneaId && userListId == other.userListId;
	}

	@Override
	public String toString() {
		return "UserListHasMiscellaneaId [userListId=" + userListId + ", miscellaneaId=" + miscellaneaId + "]";
	}
    
}
