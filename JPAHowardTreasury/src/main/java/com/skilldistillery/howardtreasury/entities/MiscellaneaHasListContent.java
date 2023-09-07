package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "miscellanea_has_list_content")
public class MiscellaneaHasListContent {
	
	@EmbeddedId
	private MiscellaneaHasListContentId id;
	
    @ManyToOne
    @JoinColumn(name = "miscellanea_id")
    @MapsId("miscellaneaId")
    private Miscellanea miscellanea;

    @ManyToOne
    @JoinColumn(name = "list_content_id")
    @MapsId("listContentId")
    private ListContent listContent;

	public MiscellaneaHasListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MiscellaneaHasListContent(MiscellaneaHasListContentId id, Miscellanea miscellanea, ListContent listContent) {
		super();
		this.id = id;
		this.miscellanea = miscellanea;
		this.listContent = listContent;
	}

	public MiscellaneaHasListContentId getId() {
		return id;
	}

	public void setId(MiscellaneaHasListContentId id) {
		this.id = id;
	}

	public Miscellanea getMiscellanea() {
		return miscellanea;
	}

	public void setMiscellanea(Miscellanea miscellanea) {
		this.miscellanea = miscellanea;
	}

	public ListContent getListContent() {
		return listContent;
	}

	public void setListContent(ListContent listContent) {
		this.listContent = listContent;
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
		MiscellaneaHasListContent other = (MiscellaneaHasListContent) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "MiscellaneaHasListContent [id=" + id + ", miscellanea=" + miscellanea + ", listContent=" + listContent
				+ "]";
	}
    
}
