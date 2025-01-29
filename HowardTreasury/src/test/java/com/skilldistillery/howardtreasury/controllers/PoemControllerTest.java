package com.skilldistillery.howardtreasury.controllers;

import static org.hamcrest.Matchers.hasSize;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.services.PoemService;

@WebMvcTest(PoemController.class)
@AutoConfigureMockMvc(addFilters = false)
class PoemControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private PoemService poemService;
    
    @Test
    void getAllPoemsByCollection_ReturnsOk_WhenPoemsExist() throws Exception {
        // Arrange
        int collectionId = 1;
        List<Poem> poems = Arrays.asList(
            new Poem(1, "Test Poem 1"),
            new Poem(2, "Test Poem 2")
        );
        when(poemService.findByCollectionId(collectionId)).thenReturn(poems);
        
        // Act & Assert
        mockMvc.perform(get("/api/collections/{cid}/poems", collectionId))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(2)))
            .andExpect(jsonPath("$[0].id").value(1))
            .andExpect(jsonPath("$[0].title").value("Test Poem 1"));
    }
    
    @Test
    void getAllPoemsByCollection_ReturnsNotFound_WhenNoPoems() throws Exception {
        // Arrange
        int collectionId = 1;
        when(poemService.findByCollectionId(collectionId)).thenReturn(new ArrayList<>());
        
        // Act & Assert
        mockMvc.perform(get("/api/collections/{cid}/poems", collectionId))
            .andExpect(status().isNotFound());
    }
}
