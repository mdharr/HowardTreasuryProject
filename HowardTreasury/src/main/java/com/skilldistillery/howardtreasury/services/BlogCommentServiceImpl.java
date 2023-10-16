package com.skilldistillery.howardtreasury.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.howardtreasury.repositories.BlogCommentRepository;

@Service
public class BlogCommentServiceImpl implements BlogCommentService {
	
	@Autowired
	private BlogCommentRepository blogCommentRepo;

}
