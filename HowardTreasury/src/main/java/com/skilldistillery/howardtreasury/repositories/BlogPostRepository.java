package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.BlogPost;
import com.skilldistillery.howardtreasury.entities.Story;

public interface BlogPostRepository extends JpaRepository<BlogPost, Integer> {

    List<BlogPost> findByTitleContainingOrContentContaining(String query);

}
