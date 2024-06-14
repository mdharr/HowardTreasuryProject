package com.skilldistillery.howardtreasury.dtos;

import java.time.LocalDateTime;
import java.util.Objects;

import com.skilldistillery.howardtreasury.entities.Series;

public class SimpleCollectionDTO {
	
	private int id;
	
	private String title;
	
	private LocalDateTime publishedAt;
	
	private Series series;

	public SimpleCollectionDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SimpleCollectionDTO(int id, String title, LocalDateTime publishedAt, Series series) {
		super();
		this.id = id;
		this.title = title;
		this.publishedAt = publishedAt;
		this.series = series;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getPublishedAt() {
		return publishedAt;
	}

	public void setPublishedAt(LocalDateTime publishedAt) {
		this.publishedAt = publishedAt;
	}

	public Series getSeries() {
		return series;
	}

	public void setSeries(Series series) {
		this.series = series;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SimpleCollectionDTO other = (SimpleCollectionDTO) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "SimpleCollectionDTO [id=" + id + ", title=" + title + ", publishedAt=" + publishedAt + ", series="
				+ series + "]";
	}
	
}
