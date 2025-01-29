package com.skilldistillery.howardtreasury.services;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.repositories.PoemRepository;

@ExtendWith(MockitoExtension.class)
public class PoemServiceTest {
    @Mock
    private PoemRepository poemRepo;
    
    @InjectMocks
    private PoemServiceImpl poemService;
    
    @Test
    void findByCollectionId_ReturnsPoems_WhenPoemsExist() {
        // Arrange
        int collectionId = 1;
        List<Poem> expectedPoems = Arrays.asList(
            new Poem(1, "Test Poem 1"),
            new Poem(2, "Test Poem 2")
        );
        when(poemRepo.findByCollections_Id(collectionId)).thenReturn(expectedPoems);
        
        // Act
        List<Poem> actualPoems = poemService.findByCollectionId(collectionId);
        
        // Assert
        assertThat(actualPoems)
            .isNotEmpty()
            .hasSize(2)
            .isEqualTo(expectedPoems);
        verify(poemRepo).findByCollections_Id(collectionId);
    }
}
