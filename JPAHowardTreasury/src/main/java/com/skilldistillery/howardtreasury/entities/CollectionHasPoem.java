package com.skilldistillery.howardtreasury.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "collection_has_poem")
public class CollectionHasPoem {

	@EmbeddedId
	private CollectionHasPoemId id;
	
	@ManyToOne
	@JoinColumn(name = "collection_id")
	@MapsId("collectionId")
	private Collection collection;
	
    @ManyToOne
    @JoinColumn(name = "poem_id")
    @MapsId("poemId")
    private Poem poem;
}
