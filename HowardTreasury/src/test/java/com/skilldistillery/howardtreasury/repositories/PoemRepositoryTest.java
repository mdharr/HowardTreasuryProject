package com.skilldistillery.howardtreasury.repositories;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.tuple;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import com.skilldistillery.howardtreasury.entities.Collection;
import com.skilldistillery.howardtreasury.entities.Poem;

@DataJpaTest
class PoemRepositoryTest {

    @Autowired
    private PoemRepository poemRepo;
    
    @Autowired
    private TestEntityManager entityManager;

    @Test
    void testFindByCollections_Id() {
    	// Arrange
        Collection collection = new Collection();
        collection = entityManager.persist(collection);
        entityManager.flush();
        
        Poem poem1 = new Poem(1, "Am-ra the Ta-an");
        if (poem1.getCollections() == null) {
            poem1.setCollections(new ArrayList<>());
        }
        poem1.getCollections().add(collection);
        
        if (collection.getPoems() == null) {
            collection.setPoems(new ArrayList<>());
        }
        collection.getPoems().add(poem1);
        
        poem1 = poemRepo.save(poem1);
        entityManager.flush();

        // Act
        List<Poem> actualPoems = poemRepo.findByCollections_Id(collection.getId());

        // Assert
        assertThat(actualPoems)
            .extracting("id", "title")
            .contains(tuple(poem1.getId(), poem1.getTitle()));
    }
    
    
}






