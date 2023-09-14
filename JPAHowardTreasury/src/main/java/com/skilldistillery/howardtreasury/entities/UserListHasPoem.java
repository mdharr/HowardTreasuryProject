package com.skilldistillery.howardtreasury.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "user_list_has_poem")
public class UserListHasPoem {

	@EmbeddedId
	private UserListHasPoemId id;
	
	@ManyToOne
	@JoinColumn(name = "user_list_id")
	@MapsId("userListId")
	private UserList userList;
	
    @ManyToOne
    @JoinColumn(name = "poem_id")
    @MapsId("poemId")
    private Poem poem;
}
