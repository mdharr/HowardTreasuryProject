package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.BlogComment;

public interface BlogCommentRepository extends JpaRepository<BlogComment, Integer> {

}
