package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.Person;

public interface PersonRepository extends JpaRepository<Person, Integer> {

}
