package com.skilldistillery.howardtreasury.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.howardtreasury.entities.ResetPasswordToken;
import com.skilldistillery.howardtreasury.entities.User;

public interface ResetPasswordTokenRepository extends JpaRepository<ResetPasswordToken, Integer> {
	ResetPasswordToken findByToken(String token);
	ResetPasswordToken findByUser(User user);
	
    @Modifying
    @Transactional
    @Query("DELETE FROM ResetPasswordToken r WHERE r.token = :token")
    void deleteByToken(@Param("token") String token);
}
