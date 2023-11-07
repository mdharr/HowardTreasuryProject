package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.VerificationToken;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {
    VerificationToken findByToken(String token);
}

