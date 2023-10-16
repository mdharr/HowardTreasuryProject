package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.BlogPost;

public interface BlogPostRepository extends JpaRepository<BlogPost, Integer> {

}
