package com.skilldistillery.howardtreasury.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name = "miscellanea_has_list_content")
public class MiscellaneaHasListContentId implements Serializable {

	private static final long serialVersionUID = 1L;
	
    @Column(name = "miscellanea_id")
    private int miscellaneaId;
    
    @Column(name = "list_content_id")
    private int listContentId;

	public MiscellaneaHasListContentId() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MiscellaneaHasListContentId(int miscellaneaId, int listContentId) {
		super();
		this.miscellaneaId = miscellaneaId;
		this.listContentId = listContentId;
	}

	public int getMiscellaneaId() {
		return miscellaneaId;
	}

	public void setMiscellaneaId(int miscellaneaId) {
		this.miscellaneaId = miscellaneaId;
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
		return Objects.hash(listContentId, miscellaneaId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MiscellaneaHasListContentId other = (MiscellaneaHasListContentId) obj;
		return listContentId == other.listContentId && miscellaneaId == other.miscellaneaId;
	}

	@Override
	public String toString() {
		return "MiscellaneaHasListContentId [miscellaneaId=" + miscellaneaId + ", listContentId=" + listContentId + "]";
	}
    
}
