package com.skilldistillery.howardtreasury.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.howardtreasury.entities.ActivationCode;
import com.skilldistillery.howardtreasury.entities.User;

public interface ActivationCodeRepository extends JpaRepository<ActivationCode, Long> {

	ActivationCode findByUserAndCode(User user, String code);
}
