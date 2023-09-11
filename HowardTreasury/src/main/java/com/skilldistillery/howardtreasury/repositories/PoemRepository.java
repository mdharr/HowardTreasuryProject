package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Poem;

public interface PoemRepository extends JpaRepository<Poem, Integer> {

}
