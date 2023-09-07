package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "poem_has_list_content")
public class PoemHasListContentId implements Serializable {

	private static final long serialVersionUID = 1L;
	
    @Column(name = "poem_id")
    private int poemId;
    
    @Column(name = "list_content_id")
    private int listContentId;

	public PoemHasListContentId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PoemHasListContentId(int poemId, int listContentId) {
		super();
		this.poemId = poemId;
		this.listContentId = listContentId;
	}

	public int getPoemId() {
		return poemId;
	}

	public void setPoemId(int poemId) {
		this.poemId = poemId;
	}

	public int getListContentId() {
		return listContentId;
	}

	public void setListContentId(int listContentId) {
		this.listContentId = listContentId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(listContentId, poemId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PoemHasListContentId other = (PoemHasListContentId) obj;
		return listContentId == other.listContentId && poemId == other.poemId;
	}

	@Override
	public String toString() {
		return "PoemHasListContentId [poemId=" + poemId + ", listContentId=" + listContentId + "]";
	}
    
}
