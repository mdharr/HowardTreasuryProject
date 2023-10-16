package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.Blog;

public interface BlogService {

	public List<Blog> findAll();
	
	public Blog find(int blogId);
}
