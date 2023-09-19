package com.skilldistillery.howardtreasury.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.CollectionImage;

public interface CollectionImageRepository extends JpaRepository<CollectionImage, Integer> {

	List<CollectionImage> findByCollections_Id(int collectionId);
}
