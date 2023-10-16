package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.entities.Blog;
import com.skilldistillery.howardtreasury.repositories.BlogRepository;

@Service
public class BlogServiceImpl implements BlogService {
	
	@Autowired
	private BlogRepository blogRepo;

	@Override
	public List<Blog> findAll() {
		return blogRepo.findAll();
	}

	@Override
	public Blog find(int blogId) {
		Optional<Blog> blogOpt = blogRepo.findById(blogId);
		if(blogOpt.isPresent()) {
			Blog blog = blogOpt.get();
			return blog;
		}
		return null;
	}

}
