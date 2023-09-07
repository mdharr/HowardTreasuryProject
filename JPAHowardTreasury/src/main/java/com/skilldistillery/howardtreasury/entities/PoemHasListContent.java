package com.skilldistillery.howardtreasury.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "poem_has_list_content")
public class PoemHasListContent {
	
	@EmbeddedId
	private PoemHasListContentId id;
	
    @ManyToOne
    @JoinColumn(name = "poem_id")
    @MapsId("poemId")
    private Poem poem;

    @ManyToOne
    @JoinColumn(name = "list_content_id")
    @MapsId("listContentId")
    private ListContent listContent;

	public PoemHasListContent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PoemHasListContent(PoemHasListContentId id, Poem poem, ListContent listContent) {
		super();
		this.id = new PoemHasListContentId(poem.getId(), listContent.getId());
		this.poem = poem;
		this.listContent = listContent;
	}

	public PoemHasListContentId getId() {
		return id;
	}

	public void setId(PoemHasListContentId id) {
		this.id = id;
	}

	public Poem getPoem() {
		return poem;
	}

	public void setPoem(Poem poem) {
		this.poem = poem;
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
		PoemHasListContent other = (PoemHasListContent) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PoemHasListContent [id=" + id + ", poem=" + poem + ", listContent=" + listContent + "]";
	}

}
