package com.skilldistillery.howardtreasury.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "weird_tales")
public class WeirdTales {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@Column(name = "published_at")
	private LocalDateTime publishedAt;
	
	@Column(name = "page_count")
	private int pageCount;
	
	@Column(name = "thumbnail_url")
	private String thumbnailUrl;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "file_url")
	private String fileUrl;
	
}
