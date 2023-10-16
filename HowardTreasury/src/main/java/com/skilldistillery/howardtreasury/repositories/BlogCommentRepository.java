package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.BlogComment;

public interface BlogCommentRepository extends JpaRepository<BlogComment, Integer> {

	List<BlogComment> findByBlogPost_Id(int blogPostId);

	List<BlogComment> findByParentCommentId(int parentCommentId);

}
