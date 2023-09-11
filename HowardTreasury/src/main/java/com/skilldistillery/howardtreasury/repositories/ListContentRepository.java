package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.ListContent;

public interface ListContentRepository extends JpaRepository<ListContent, Integer> {

}
